import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WebLink extends StatefulWidget {
  const WebLink({
    super.key,
    required this.text,
    this.color,
    this.hoverColor = Colors.black,
    this.underline = false,
    this.underlineHover = false,
    this.onTap,
  });
  final String text;
  final Color? color;
  final Color hoverColor;
  final bool underline;
  final bool underlineHover;
  final VoidCallback? onTap;
  @override
  State<WebLink> createState() => _WebLinkState();
}

class _WebLinkState extends State<WebLink> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));
  late final Animation<Color?> _animation = ColorTween(
          begin: widget.color ?? DefaultTextStyle.of(context).style.color,
          end: widget.hoverColor)
      .animate(_controller);
  final ValueNotifier<bool> _underline = ValueNotifier(false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        if (widget.underline && widget.underlineHover) {
          _underline.value = true;
        }
        _controller.forward();
      },
      onExit: (e) {
        if (widget.underline && widget.underlineHover) {
          _underline.value = false;
        }
        _underline.value = false;
        _controller.reverse();
      },
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ValueListenableBuilder<bool>(
                valueListenable: _underline,
                builder: (context, value, _) {
                  return Transform.translate(
                    offset: const Offset(0, 5),
                    child: SelectableText.rich(
                      maxLines: 1,
                      TextSpan(
                        text: widget.text,
                        style: TextStyle(
                          color: Colors.transparent,
                          shadows: [
                            Shadow(
                              color: _animation.value!,
                              offset: const Offset(0, -5),
                            )
                          ],
                          decoration: value
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: _animation.value,
                        ),
                        recognizer: (TapGestureRecognizer()
                          ..onTap = widget.onTap),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
