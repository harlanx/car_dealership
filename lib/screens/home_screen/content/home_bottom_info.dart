import 'package:flutter/material.dart';

import '../../../data/app_data.dart';
import '../../../utilities/utilities.dart';

class HomeBottomInfo extends StatelessWidget {
  const HomeBottomInfo({
    super.key,
    required this.size,
  });
  final Size size;

  bool get _screenLarge {
    final sWidth = size.width;
    return sWidth >= 1280;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppData.colorSwatch.shade900,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        runSpacing: 50,
        spacing: _screenLarge ? 120 : 80,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/logo.png',
                      fit: BoxFit.scaleDown,
                      width: 50,
                      filterQuality: FilterQuality.low,
                      isAntiAlias: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const WebLink(
                  text: 'Silvian Automobile PH',
                  color: Colors.white,
                  hoverColor: Colors.white,
                  underline: true,
                  underlineHover: true,
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: SelectableText(
                    AppData.companyInfo,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DisplayLogo(
                      path: SocialLogos.sourceImage,
                      x: SocialLogos.facebook.x,
                      y: SocialLogos.facebook.y,
                    ),
                    DisplayLogo(
                      path: SocialLogos.sourceImage,
                      x: SocialLogos.x.x,
                      y: SocialLogos.x.y,
                    ),
                    DisplayLogo(
                      path: SocialLogos.sourceImage,
                      x: SocialLogos.instagram.x,
                      y: SocialLogos.instagram.y,
                    ),
                    DisplayLogo(
                      path: SocialLogos.sourceImage,
                      x: SocialLogos.youtube.x,
                      y: SocialLogos.youtube.y,
                    ),
                  ],
                ),
              ],
            ),
          ),
          for (var group in infoGroups.entries)
            BottomInfo(
              header: group.key,
              items: {
                for (var item in group.value) item: '',
              },
            ),
        ],
      ),
    );
  }
}

class BottomInfo extends StatefulWidget {
  const BottomInfo({
    super.key,
    required this.header,
    required this.items,
  });

  final String header;
  final Map<String, String> items;

  @override
  State<BottomInfo> createState() => _BottomInfoState();
}

class _BottomInfoState extends State<BottomInfo> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 280,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          SelectableText(
            widget.header,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 19),
          // Items
          ...<Widget>[
            for (var item in widget.items.entries)
              BottomInfoItem(
                label: item.key,
                url: item.value,
              )
          ].insertBetween(const SizedBox(height: 10)),
        ],
      ),
    );
  }
}

class BottomInfoItem extends StatefulWidget {
  const BottomInfoItem({
    super.key,
    required this.label,
    this.url = '',
  });

  final String label;
  final String url;

  @override
  State<BottomInfoItem> createState() => _BottomInfoItemState();
}

class _BottomInfoItemState extends State<BottomInfoItem>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));

  late final _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);

  late final _textColor = ColorTween(
    begin: Colors.white,
    end: AppData.color,
  ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: () {},
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset.fromDirection(0, _animation.value * 5),
              child: Text(
                widget.label,
                style: TextStyle(
                  color: _textColor.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
