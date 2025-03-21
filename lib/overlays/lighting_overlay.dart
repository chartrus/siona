import 'package:flutter/material.dart';

class LightingOverlay extends StatelessWidget {
  final double ambientLight;
  final Color skyColor;

  const LightingOverlay({
    super.key,
    required this.ambientLight,
    required this.skyColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LightingPainter(
        ambientLight: ambientLight,
        skyColor: skyColor,
      ),
      child: Container(),
    );
  }
}

class LightingPainter extends CustomPainter {
  final double ambientLight;
  final Color skyColor;

  LightingPainter({
    required this.ambientLight,
    required this.skyColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 하늘 배경
    final skyPaint = Paint()
      ..color = skyColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, skyPaint);

    // 조명 효과
    final lightPaint = Paint()
      ..color = Colors.black.withOpacity(1.0 - ambientLight)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, lightPaint);
  }

  @override
  bool shouldRepaint(LightingPainter oldDelegate) {
    return oldDelegate.ambientLight != ambientLight ||
           oldDelegate.skyColor != skyColor;
  }
} 