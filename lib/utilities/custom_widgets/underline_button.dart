import 'package:flutter/material.dart';

import '../extensions.dart';

class UnderlineButton extends StatefulWidget {
  const UnderlineButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<UnderlineButton> createState() => _UnderlineButtonState();
}

class _UnderlineButtonState extends State<UnderlineButton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    final textSize = widget.text.textSize(
      style: style,
    );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: SizedBox(
        width: textSize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  margin: const EdgeInsets.only(top: 2),
                  color: style.color,
                  height: 2,
                  width: textSize.width * _animation.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
