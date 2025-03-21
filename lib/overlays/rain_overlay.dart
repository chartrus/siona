import 'package:flutter/material.dart';

class RainOverlay extends StatelessWidget {
  final double intensity;

  const RainOverlay({
    super.key,
    required this.intensity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RainPainter(intensity: intensity),
      child: Container(),
    );
  }
}

class RainPainter extends CustomPainter {
  final double intensity;

  RainPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.3 * intensity)
      ..strokeWidth = 1.0;

    for (var i = 0; i < size.width; i += 5) {
      for (var j = 0; j < size.height; j += 5) {
        if (i % 10 == 0 && j % 10 == 0) {
          canvas.drawLine(
            Offset(i.toDouble(), j.toDouble()),
            Offset(i.toDouble(), (j + 10).toDouble()),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(RainPainter oldDelegate) {
    return oldDelegate.intensity != intensity;
  }
} 