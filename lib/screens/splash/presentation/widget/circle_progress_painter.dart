import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  CircleProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 12.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track Paint (Light Faded Green)
    final trackPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Progress Paint (Dark Green)
    final progressPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw full outer light track
    canvas.drawCircle(center, radius, trackPaint);

    // Draw active animated arc
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}