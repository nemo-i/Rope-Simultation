import 'package:flutter/material.dart';

class DBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //     Rect.fromLTWH(0, 0, 200, 200), Paint()..color = Colors.white);

    canvas.scale(5, 5);
    Paint side1_paint = Paint()..color = Color(0xFFafafde);
    Path box_side1 = Path();
    box_side1.moveTo(41.961316, 129.06088);
    box_side1.relativeLineTo(17.10525, -7.92423);
    box_side1.relativeLineTo(18.609355, 3.37377);
    box_side1.relativeLineTo(-20.451153, 6.31617);
    box_side1.close();
    canvas.drawPath(box_side1, side1_paint);

    Paint side2_paint = Paint()..color = Color(0xFFd7d7ff);
    Path box_side2 = Path();
    box_side2.moveTo(59.066566, 93.428479);
    box_side2.relativeLineTo(0, 27.708171);
    box_side2.relativeLineTo(18.609355, 3.37377);
    box_side2.relativeLineTo(0, -24.29189);
    box_side2.close();
    canvas.drawPath(box_side2, side2_paint);

    Paint side3_paint = Paint()..color = Color(0xFF8686bf);
    Path box_side3 = Path();
    box_side3.moveTo(41.961316, 109.37679);
    box_side3.relativeLineTo(17.10525, -15.948311);
    box_side3.relativeLineTo(0, 27.708171);
    box_side3.relativeLineTo(-17.10525, 7.92423);
    box_side3.close();
    canvas.drawPath(box_side3, side3_paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
