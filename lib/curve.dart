// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

class CurveLine extends CustomPainter {
  final Offset circleOffset;
  final Offset lineEnd;
  CurveLine({
    this.circleOffset = const Offset(200, 70),
    this.lineEnd = const Offset(400, 70),
  });

  @override
  void paint(Canvas canvas, Size size) {
    double h = 140;
    final y = lineEnd.dx - circleOffset.dx;

    log(y.toString());
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final fingerPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final path = Path();

    // canvas.drawCircle(
    //     Offset((circleOffset.dx - 10) / 2, y.isNegative ? 70 : y + 70),
    //     10,
    //     fingerPaint..color = Colors.red);
    path.moveTo(10, 70);
    path.quadraticBezierTo(
      (circleOffset.dx - 10) / 2,
      y.isNegative ? 70 : y + 70,
      circleOffset.dx,
      circleOffset.dy,
    );
    canvas.drawPath(path, paint);
    // canvas.drawRect(
    //     Rect.fromCircle(center: const Offset(10, 70), radius: 10), fingerPaint);
    canvas.drawCircle(circleOffset, 10, fingerPaint);
    // canvas.drawCircle(lineEnd, 10, fingerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
