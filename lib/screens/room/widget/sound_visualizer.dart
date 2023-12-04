import 'package:flutter/material.dart';

class SoundVisualizer extends StatefulWidget {
  const SoundVisualizer({Key? key}) : super(key: key);

  @override
  SoundVisualizerState createState() => SoundVisualizerState();
}

class SoundVisualizerState extends State<SoundVisualizer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = Tween(begin: 0.7, end: 1.0).animate(_controller)
      ..addListener(() {
        setState((){});
      });

    // Start the animation loop when the widget is built
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleVisualizerPainter(_animation.value),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircleVisualizerPainter extends CustomPainter {
  final double animationValue;

  CircleVisualizerPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    double maxRadius = size.width / 2;

    Paint outerCirclePaint = Paint()
      ..color = Colors.white.withOpacity(0.3 * (1 - animationValue))
      ..style = PaintingStyle.fill;

    Paint innerCirclePaint = Paint()
      ..shader = RadialGradient(
        colors: const [Colors.transparent,Colors.white54],
        stops: [1 - animationValue, 1.0],
        tileMode: TileMode.clamp,
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: maxRadius,
      ))
      ..style = PaintingStyle.fill;

    double outerRadius = maxRadius * animationValue;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      maxRadius,
      outerCirclePaint,
    );

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      outerRadius,
      innerCirclePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
