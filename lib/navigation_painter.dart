import 'dart:developer';
import 'dart:math' show pi;

import 'package:flutter/material.dart';

class NavigationPainter extends CustomPainter {
  final int count;

  NavigationPainter(this.count);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    final offset = Offset(size.width / 2, size.height / 2);
    final rect =
        Rect.fromCenter(center: offset, width: size.width, height: size.height);

    double start = pi;
    double sweepAngle = pi / 4;

    List<Color> colors = [
      Colors.pink,
      Colors.green,
      Colors.blue,
      Colors.orange
    ];
    for (var i = 0; i < count; i++) {
      canvas.drawArc(
        rect,
        start,
        sweepAngle,
        true,
        paint
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5,
      );
      log(
        sweepAngle.toString(),
      );
      canvas.drawArc(
          rect,
          start,
          sweepAngle,
          true,
          paint
            ..color = colors[i]
            ..style = PaintingStyle.fill
            ..strokeWidth = 5);
      log(
        sweepAngle.toString(),
      );
      start += pi / 4;
    }
    canvas.drawArc(
        Rect.fromCenter(
            center: offset, width: size.width / 2, height: size.height / 2),
        pi,
        pi,
        true,
        paint..color = Colors.indigo);
    canvas.drawArc(
        Rect.fromCenter(
            center: offset, width: size.width / 2, height: size.height / 2),
        pi,
        pi,
        true,
        paint
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
