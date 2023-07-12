import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../utilities/utilities.dart';

final _leadingItems = <HomeHeaderItem>[
  HomeHeaderItem(
      key: 'Models', content: const HomeHeaderItemContent(color: Colors.blue)),
  HomeHeaderItem(
      key: 'Dealers',
      content: const HomeHeaderItemContent(color: Colors.green)),
  HomeHeaderItem(
      key: 'Services',
      content: const HomeHeaderItemContent(color: Colors.yellow)),
  HomeHeaderItem(key: 'Careers'),
];

final _trailingItems = <HomeHeaderItem>[
  HomeHeaderItem(key: 'Store'),
  HomeHeaderItem(key: 'FAQ'),
  HomeHeaderItem(key: 'About Us'),
  HomeHeaderItem(key: 'Contact Us'),
];

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
      _menuCtrlr = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );

  late final Animation<double> _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
      _menuAnim = CurvedAnimation(
        parent: _menuCtrlr,
        curve: Curves.fastOutSlowIn,
      );

  final _contentFocused = ValueNotifier<bool>(false);

  String _focusedItem = '';

  @override
  void dispose() {
    _controller.dispose();
    _menuCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        _menuCtrlr.reverse();
        _controller.reverse();
        _contentFocused.value = false;
      },
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppData.color,
                    width: 1.5,
                  ),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedWidthFlexible(
                          flex: 1,
                          flexSum: 2,
                          minWidth: 400,
                          maxWidth: 650,
                          outerConstraints: constraints,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 8),
                                  child: InkWell(
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
                              ...[
                                for (var item in _leadingItems)
                                  _headerItemBox(item, context)
                              ],
                            ],
                          ),
                        ),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Visibility(
                                    visible: constraints.maxWidth >= 1020,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (var item in _trailingItems)
                                          _headerItemBox(item, context)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: IconButton(
                                    icon: AnimatedIcon(
                                      icon: AnimatedIcons.menu_close,
                                      progress: _menuAnim,
                                    ),
                                    onPressed: () {
                                      if (_menuCtrlr.status ==
                                          AnimationStatus.dismissed) {
                                        _menuCtrlr.forward();
                                        _controller.forward();
                                      } else {
                                        _menuCtrlr.reverse();
                                        _controller.reverse();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            HomeHeaderContentBox(
              animation: _animation,
              focusedItem: _focusedItem,
              items: _leadingItems,
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerItemBox(HomeHeaderItem item, BuildContext context) {
    final Size size = (TextPainter(
            text: TextSpan(
              text: item.key.toUpperCase(),
              style: const TextStyle(fontSize: 15),
            ),
            maxLines: 1,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            _focusedItem = item.key;
          });
          _menuCtrlr.reverse();
          _contentFocused.value = true;
          if (item.hasContent) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 95,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: item.child ??
                      Text(
                        item.key.toUpperCase(),
                        style: const TextStyle(fontSize: 15),
                      ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ValueListenableBuilder<bool>(
                  valueListenable: _contentFocused,
                  builder: (context, val, child) {
                    final bool shouldExpand = val && _focusedItem == item.key;
                    return AnimatedSize(
                      duration: _controller.duration! * 0.7,
                      child: Container(
                        color: DefaultTextStyle.of(context).style.color,
                        width: shouldExpand ? size.width : 0,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeaderItem {
  HomeHeaderItem({
    required this.key,
    this.content,
    this.child,
    this.onTap,
  });

  final String key;
  final Widget? child;
  final HomeHeaderItemContent? content;
  final VoidCallback? onTap;

  bool get hasContent => content != null;
}

class HomeHeaderItemContent {
  const HomeHeaderItemContent({
    Key? key,
    this.child,
    this.alignment = Alignment.center,
    this.color = Colors.grey,
  });

  final Widget? child;
  final Alignment alignment;
  final MaterialColor color;

  final List _colorShades = const <int>[
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  ];

  Widget get contentChild {
    if (child != null) {
      return child!;
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i in _colorShades.reversed)
            Container(
              color: color[i],
              height: 20,
            ),
        ],
      );
    }
  }
}

class HomeHeaderContentBox extends StatefulWidget {
  const HomeHeaderContentBox({
    Key? key,
    required this.items,
    required this.focusedItem,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;
  final String focusedItem;
  final List<HomeHeaderItem> items;

  @override
  State<HomeHeaderContentBox> createState() => _HomeHeaderContentBoxState();
}

class _HomeHeaderContentBoxState extends State<HomeHeaderContentBox> {
  int lastFocused = 0;

  int get _focusedIndex {
    final index =
        widget.items.indexWhere((element) => element.key == widget.focusedItem);
    if (index < 0) {
      return lastFocused;
    } else {
      if (widget.items[index].hasContent) {
        lastFocused = index;
        return index;
      }
      return lastFocused;
    }
  }

  List<Widget> get _itemChildren {
    final List<Widget> children = [];
    for (var e in widget.items) {
      if (e.hasContent) {
        children.add(e.content!.contentChild);
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: widget.animation,
        axis: Axis.vertical,
        child: IndexedStack(
          index: _focusedIndex,
          children: _itemChildren,
        ));
  }
}
