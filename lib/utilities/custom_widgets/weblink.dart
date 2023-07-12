import 'dart:js_interop';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WebLink extends StatefulWidget {
  const WebLink({
    Key? key,
    required this.text,
    this.hoverColor = Colors.black,
    this.onTap,
  }) : super(key: key);
  final String text;
  final Color hoverColor;
  final VoidCallback? onTap;
  @override
  State<WebLink> createState() => _WebLinkState();
}

class _WebLinkState extends State<WebLink> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));
  late final Animation<Color?> _animation = ColorTween(
          begin: DefaultTextStyle.of(context).style.color,
          end: widget.hoverColor)
      .animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        _controller.forward();
      },
      onExit: (e) {
        _controller.reverse();
      },
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SelectableText.rich(
              TextSpan(
                text: widget.text,
                style: TextStyle(color: _animation.value),
                recognizer: !widget.onTap.isNull
                    ? (TapGestureRecognizer()..onTap = widget.onTap)
                    : null,
              ),
            );
          }),
    );
  }
}
