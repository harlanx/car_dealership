import 'dart:math';
import 'package:flutter/material.dart';

class PolyButton extends StatefulWidget {
  const PolyButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style = const PolyButtonStyle(),
  });
  final Widget child;
  final VoidCallback? onPressed;
  final PolyButtonStyle style;

  @override
  State<PolyButton> createState() => _PolyButtonState();
}

class _PolyButtonState extends State<PolyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation _fillColor = ColorTween(
    begin: widget.style.initialColor,
    end: widget.style.endColor,
  ).animate(_controller);

  late final Animation _childColor = ColorTween(
    begin: widget.style.childColor,
    end: widget.style.endChildColor,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (pte) {
          _controller.forward();
        },
        onExit: (pte) {
          _controller.reverse();
        },
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: widget.style.size,
          width: widget.style.size,
          child: CustomPaint(
            painter: PolyPainter(
              sides: widget.style.sides,
              borderColor: widget.style.borderColor,
              fillColor: _fillColor.value,
              borderSize: widget.style.borderSize,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
                  color: _childColor.value,
                ),
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class PolyPainter extends CustomPainter {
  PolyPainter({
    required this.borderColor,
    required this.fillColor,
    required this.borderSize,
    required this.sides,
  }) : assert(sides > 2, 'Sides must be greater than 2');
  Color borderColor;
  Color fillColor;
  double borderSize;
  int sides;

  @override
  void paint(Canvas canvas, Size size) {
    final Path pathFill = Path();
    Path pathBorder = Path();
    final Alignment center = Alignment(size.width / 2, size.height / 2);
    final Point<double> radius = Point(size.width / 2, size.height / 2);
    final double angle = pi * 2 / sides;
    pathFill.moveTo(
        center.x + radius.x * cos(angle), center.y + radius.y * sin(angle));
    for (int i = 0; i <= sides; i++) {
      final x = cos(angle * i) * radius.x + center.x;
      final y = sin(angle * i) * radius.y + center.y;
      pathFill.lineTo(x, y);
    }
    pathFill.close();
    pathBorder = pathFill;

    final Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = fillColor;

    final Paint paintBorder = Paint()..style = PaintingStyle.stroke;
    paintBorder.color = borderColor;
    paintBorder.strokeWidth = borderSize;

    canvas.drawPath(pathFill, paintFill);
    canvas.drawPath(pathBorder, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PolyButtonStyle {
  final Color borderColor;
  final Color initialColor;
  final Color endColor;
  final Color childColor;
  final Color endChildColor;
  final double borderSize;
  final double size;
  final int sides;

  const PolyButtonStyle({
    this.borderColor = Colors.white,
    this.initialColor = Colors.transparent,
    this.endColor = Colors.white,
    this.childColor = Colors.white,
    this.endChildColor = Colors.black,
    this.borderSize = 2.0,
    this.size = 36,
    this.sides = 6,
  });
}
