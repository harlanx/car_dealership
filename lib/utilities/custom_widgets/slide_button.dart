import 'package:flutter/material.dart';

import '../extensions.dart';

enum SlidePosition {
  left,
  right,
  top,
  bottom,
}

class SlideButton extends StatefulWidget {
  const SlideButton({
    super.key,
    required this.label,
    this.style,
    this.bgColor = Colors.white,
    this.fgColor = Colors.black,
    this.labelColor,
    Color? borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    this.position = SlidePosition.left,
    required this.onPressed,
    required,
  }) : borderColor = borderColor ?? fgColor;

  final String label;
  final TextStyle? style;
  final Color bgColor;
  final Color fgColor;
  final Color? labelColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final SlidePosition position;
  final VoidCallback onPressed;

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final labelAnimation = ColorTween(
    begin: widget.fgColor,
    end: widget.bgColor,
  ).animate(_controller);
  late Size txtSize;
  late Size btnSize;
  TextStyle? style;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    style = widget.style ?? Theme.of(context).textTheme.bodyMedium;
    txtSize = widget.label.textSize(style: style);
    btnSize = Size(
      txtSize.width + widget.padding.horizontal,
      txtSize.height + widget.padding.vertical,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        _controller.forward();
      },
      onExit: (_) {
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: () => widget.onPressed,
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Container(
              width: btnSize.width,
              height: btnSize.height,
              decoration: BoxDecoration(
                color: widget.bgColor,
                border: Border.all(
                  color: widget.borderColor,
                  width: 2.0,
                ),
              ),
            ),
            FillColorAnimation(
              animation: _controller,
              bgColor: widget.fgColor,
              btnSize: btnSize,
              position: widget.position,
            ),
            SizedBox(
              width: btnSize.width,
              height: btnSize.height,
              child: AnimatedBuilder(
                animation: labelAnimation,
                builder: (context, child) {
                  return Center(
                    child: Text(
                      widget.label,
                      style: widget.style?.copyWith(
                        color: widget.labelColor ?? labelAnimation.value,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FillColorAnimation extends AnimatedWidget {
  const FillColorAnimation({
    super.key,
    required this.animation,
    required this.bgColor,
    required this.btnSize,
    required this.position,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final Color bgColor;
  final Size btnSize;
  final SlidePosition position;

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  Animation<double> get heightAnimation => Tween<double>(
        begin: isTop ? 0 : btnSize.height,
        end: isTop ? btnSize.height : 0,
      ).animate(curvedAnimation);

  Animation<double> get widthAnimation => Tween<double>(
        begin: isLeft ? 0 : btnSize.width,
        end: isLeft ? btnSize.width : 0,
      ).animate(curvedAnimation);

  bool get isTop => position == SlidePosition.top;
  bool get isLeft => position == SlidePosition.left;
  bool get isVertical => isTop || position == SlidePosition.bottom;
  bool get isHorizontal =>
      position == SlidePosition.left || position == SlidePosition.right;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHorizontal ? widthAnimation.value : btnSize.width,
      height: isVertical ? heightAnimation.value : btnSize.height,
      decoration: BoxDecoration(
        color: bgColor,
      ),
    );
  }
}
