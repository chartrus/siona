import 'package:flutter/material.dart';
import 'dart:math' as math;

class SnowOverlay extends StatelessWidget {
  final double intensity;

  const SnowOverlay({
    super.key,
    required this.intensity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SnowPainter(intensity: intensity),
      child: Container(),
    );
  }
}

class SnowPainter extends CustomPainter {
  final double intensity;
  final List<Snowflake> snowflakes = [];

  SnowPainter({required this.intensity}) {
    // 눈송이 초기화
    for (var i = 0; i < 50; i++) {
      snowflakes.add(Snowflake());
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8 * intensity)
      ..style = PaintingStyle.fill;

    for (var snowflake in snowflakes) {
      snowflake.update(size);
      canvas.drawCircle(
        Offset(snowflake.x, snowflake.y),
        snowflake.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) {
    return oldDelegate.intensity != intensity;
  }
}

class Snowflake {
  late double x;
  late double y;
  final double size = math.Random().nextDouble() * 3 + 1;
  final double speed = math.Random().nextDouble() * 2 + 1;
  final double wind = math.Random().nextDouble() * 0.5 - 0.25;

  Snowflake() {
    reset();
  }

  void reset() {
    x = math.Random().nextDouble() * 1000;
    y = -10;
  }

  void update(Size size) {
    y += speed;
    x += wind;

    if (y > size.height + 10) {
      reset();
    }
  }
} 