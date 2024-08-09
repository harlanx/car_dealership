import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../data/app_data.dart';
import '../../../models/models.dart';
import '../../../utilities/utilities.dart';

class HomeHeaderMenu extends StatefulWidget {
  const HomeHeaderMenu({
    super.key,
    required this.label,
    required this.items,
    required this.activeContent,
    this.textStyle,
    this.onTap,
    this.content,
  });

  final String label;
  final List<MenuItem> items;
  final ValueNotifier<String> activeContent;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final HomeHeaderContentBox? content;

  @override
  State<HomeHeaderMenu> createState() => _HomeHeaderMenuState();
}

class _HomeHeaderMenuState extends State<HomeHeaderMenu>
    with SingleTickerProviderStateMixin {
  late final _labelSize =
      widget.label.toUpperCase().textSize(style: widget.textStyle);
  late final menu =
      widget.items.singleWhere((menu) => menu.label == widget.label);
  late final exceptMenu =
      widget.items.where((menu) => menu.label != widget.label);
  late final _animation = CurvedAnimation(
    parent: menu.controller,
    curve: Curves.decelerate,
  );

  @override
  Widget build(BuildContext context) {
    final isMainMenu = menu.label == 'Menu';
    // Main Menu
    if (isMainMenu) {
      return IconButton(
        onPressed: () {
          if (_animation.status == AnimationStatus.dismissed) {
            widget.activeContent.value = widget.label;
            menu.controller.forward();
          } else {
            widget.activeContent.value = '';
            menu.controller.reverse();
          }
          for (var except in exceptMenu) {
            except.controller.reverse();
          }
        },
        icon: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animation,
            );
          },
        ),
      );
    }

    // Labeled Menu
    return ValueListenableBuilder<String>(
        valueListenable: widget.activeContent,
        builder: (context, value, content) {
          final isMenuActive = value == 'Menu';
          return MouseRegion(
            cursor: !isMenuActive
                ? SystemMouseCursors.click
                : SystemMouseCursors.basic,
            onEnter: (event) {
              if (!isMenuActive) {
                widget.activeContent.value = widget.label;
                menu.controller.forward();
                for (var except in exceptMenu) {
                  except.controller.reverse();
                }
              }
            },
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    menu.context = context;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: AnimatedDefaultTextStyle(
                              style:
                                  DefaultTextStyle.of(context).style.copyWith(
                                        color: !isMenuActive
                                            ? widget.textStyle?.color
                                            : Colors.grey.shade700,
                                      ),
                              duration: menu.controller.duration!,
                              child: Text(
                                widget.label.toUpperCase(),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 5,
                          width: _labelSize.width * _animation.value,
                          color: DefaultTextStyle.of(context).style.color,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class LeadingMenus extends StatefulWidget {
  const LeadingMenus({
    super.key,
    required this.controller,
    required this.activeContent,
    required this.items,
    required this.allItems,
    required this.showMenus,
  });

  final AnimationController controller;
  final ValueNotifier<String> activeContent;
  final List<MenuItem> items;
  final List<MenuItem> allItems;
  final bool showMenus;

  @override
  State<LeadingMenus> createState() => LeadingMenusState();
}

class LeadingMenusState extends State<LeadingMenus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => {},
              child: Image.asset(
                'assets/icons/logo.png',
                fit: BoxFit.scaleDown,
                filterQuality: FilterQuality.low,
                isAntiAlias: true,
              ),
            ),
          ),
        ),
        for (var item in widget.items)
          Flexible(
            key: ValueKey(item.label),
            child: Offstage(
              offstage: !widget.showMenus,
              child: HomeHeaderMenu(
                label: item.label,
                items: widget.allItems,
                activeContent: widget.activeContent,
              ),
            ),
          ),
      ],
    );
  }
}

class TrailingMenus extends StatefulWidget {
  const TrailingMenus({
    super.key,
    required this.controller,
    required this.activeContent,
    required this.items,
    required this.allItems,
    required this.showMenus,
  });

  final AnimationController controller;
  final ValueNotifier<String> activeContent;
  final List<MenuItem> items;
  final List<MenuItem> allItems;
  final bool showMenus;

  @override
  State<TrailingMenus> createState() => _TrailingMenusState();
}

class _TrailingMenusState extends State<TrailingMenus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!widget.showMenus) ...[
          IconButton(onPressed: () {}, icon: const Icon(Icons.message_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
        ],
        for (var item in widget.items)
          Flexible(
            key: ValueKey(item.label),
            child: Offstage(
              offstage: !widget.showMenus && item.label != 'Menu',
              child: HomeHeaderMenu(
                label: item.label,
                items: widget.allItems,
                activeContent: widget.activeContent,
              ),
            ),
          ),
      ],
    );
  }
}

class HomeHeaderContentBox extends StatefulWidget {
  const HomeHeaderContentBox({
    super.key,
    required this.controller,
    required this.animation,
    required this.activeContent,
    required this.contents,
    required this.size,
  });

  final AnimationController controller;
  final CurvedAnimation animation;
  final ValueNotifier<String> activeContent;
  final List<MenuItem> contents;
  final Size size;

  @override
  State<HomeHeaderContentBox> createState() => _HomeHeaderContentBoxState();
}

class _HomeHeaderContentBoxState extends State<HomeHeaderContentBox>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.activeContent,
      builder: (context, value, child) {
        final menu =
            widget.contents.singleWhereOrNull((item) => item.label == value);
        final isMainMenu = value == 'Menu';
        Widget result;
        if (isMainMenu) {
          result = KeyedSubtree(
            key: ValueKey(value),
            child: menu!.menuChild!,
          );
        } else if (value.isEmpty || menu?.content == null) {
          result = SizedBox(key: ValueKey(value));
        } else {
          final labelPos = menu?.context?.globalPaintBounds;

          // Non-Aligned to the label
          // result = KeyedSubtree(
          //   key: ValueKey(value),
          //   child: menu!.content!,
          // );

          // Aligned to the label
          result = Padding(
            padding: EdgeInsets.only(left: labelPos?.left ?? 0.0),
            key: ValueKey(value),
            child: HomeHeaderContentItem(items: menu!.content!),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // 650 + 50*2 for each side of horizontal padding of MainMenuContent
            final screenSmall = constraints.maxWidth <= 750;
            return Container(
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              child: AnimatedSize(
                duration: widget.controller.duration!,
                curve: widget.animation.curve,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: isMainMenu && screenSmall
                      ? widget.size.height - 78
                      : null,
                  child: result,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class HomeHeaderMenuContent extends StatefulWidget {
  const HomeHeaderMenuContent({
    super.key,
    required this.items,
    required this.leadingItems,
    required this.trailingItems,
  });

  final List<String> items;
  final List<MenuItem> leadingItems;
  final List<MenuItem> trailingItems;

  @override
  State<HomeHeaderMenuContent> createState() => _HomeHeaderMenuContentState();
}

class _HomeHeaderMenuContentState extends State<HomeHeaderMenuContent> {
  @override
  Widget build(BuildContext context) {
    final itemList = widget.items.divide(3, reverse: true).toList();

    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenSmall = constraints.maxWidth <= 650;
            Widget child;
            if (!screenSmall) {
              child = Column(
                key: const ValueKey('MenuItemContent'),
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var list in itemList) ...[
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var item in list)
                                  Flexible(child: UnderlineButton(text: item))
                              ].insertBetween(
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints.expand(height: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ].insertBetween(
                        Flexible(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 200),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 450),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Languages'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Flexible(
                                  child: Wrap(
                                    spacing: 30,
                                    runSpacing: 20,
                                    children: [
                                      for (var language in languages)
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            language.toUpperCase(),
                                            style: TextStyle(
                                              color: language != languages.first
                                                  ? Colors.white
                                                  : Colors.grey,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 120),
                            child: const SizedBox(
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Social'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Flexible(
                                child: Wrap(
                                  spacing: 30,
                                  runSpacing: 20,
                                  children: [
                                    for (var logo in SocialLogos.logos)
                                      DisplayLogo(
                                        path: SocialLogos.sourceImage,
                                        x: logo.x,
                                        y: logo.y,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              child = ListView(
                key: const ValueKey('MenuItemContent'),
                shrinkWrap: true,
                children: [
                  for (var item in widget.items)
                    ListTile(
                      onTap: () {},
                      title: Text(
                        item,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              );
            }
            return child;
          },
        ),
      ),
    );
  }
}

class HomeHeaderContentItem extends StatefulWidget {
  const HomeHeaderContentItem({
    super.key,
    required this.items,
  });

  final List<MenuContentItem> items;

  @override
  State<HomeHeaderContentItem> createState() => _HomeHeaderContentItemState();
}

class _HomeHeaderContentItemState extends State<HomeHeaderContentItem> {
  final secondRow = ValueNotifier<List<MenuContentItem>?>([]);
  String activeItem = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in widget.items)
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: MouseRegion(
                      onEnter: (event) {
                        secondRow.value = item.items;
                        if (item.items != null) {
                          activeItem = item.label;
                        }
                      },
                      cursor: item.items == null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                      child: ValueListenableBuilder(
                        valueListenable: secondRow,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.label.toUpperCase()),
                              if (activeItem == item.label)
                                const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 18,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: secondRow,
            builder: (context, value, child) {
              if (value != null) {
                return Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in value)
                        DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: MouseRegion(
                              cursor: item.items == null
                                  ? SystemMouseCursors.click
                                  : SystemMouseCursors.basic,
                              child: Text(item.label.toUpperCase()),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}

// Main Widget
class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with TickerProviderStateMixin {
  late final _leadingItems = <MenuItem>[
    MenuItem(
      label: 'Models',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
      content: modelsContent,
    ),
    MenuItem(
      label: 'Dealers',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
      content: dealersContent,
    ),
    MenuItem(
      label: 'Services',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
      content: servicesContent,
    ),
    MenuItem(
      label: 'Careers',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
      content: carrersContent,
    ),
  ];

  late final _trailingItems = <MenuItem>[
    MenuItem(
      label: 'Store',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    ),
    MenuItem(
      label: 'FAQ',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    ),
    MenuItem(
      label: 'About Us',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    ),
    MenuItem(
      label: 'Contact Us',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    ),
    MenuItem(
      label: 'Menu',
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
      menuChild: HomeHeaderMenuContent(
        items: mainMenuContent,
        // TODO: Move Header Menu Items to LisTile
        leadingItems: const [],
        trailingItems: const [],
      ),
    ),
  ];

  late final _contentController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final _contentAnimation = CurvedAnimation(
    parent: _contentController,
    curve: Curves.decelerate,
  );

  late final _allItems = [
    ..._leadingItems,
    ..._trailingItems,
  ];

  final activeContent = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        for (var item in _allItems) {
          item.controller.reverse();
        }
        activeContent.value = '';
        _contentController.reverse();
      },
      child: MouseRegion(
        onExit: (event) {
          if (activeContent.value != 'Menu') {
            activeContent.value = '';
            for (var item in _allItems) {
              item.controller.reverse();
            }
            _contentController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _contentAnimation,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.black,
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final showLeading = constraints.maxWidth > 1000;
                        final showTrailing = constraints.maxWidth > 600;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LeadingMenus(
                              controller: _contentController,
                              items: _leadingItems,
                              allItems: _allItems,
                              activeContent: activeContent,
                              showMenus: showLeading,
                            ),
                            TrailingMenus(
                              controller: _contentController,
                              items: _trailingItems,
                              allItems: _allItems,
                              activeContent: activeContent,
                              showMenus: showTrailing,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: HomeHeaderContentBox(
                    controller: _contentController,
                    animation: _contentAnimation,
                    activeContent: activeContent,
                    contents: _allItems,
                    size: widget.size,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
