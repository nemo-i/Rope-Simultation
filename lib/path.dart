import 'dart:async';

import 'package:flutter/material.dart'
    show BuildContext, Colors, createLocalImageConfiguration;
import 'package:flutter/rendering.dart';

class FloatingPaint extends CustomPainter {
  final Color color;
  final Color circleColor;
  final double strokeWidth;
  final double scale;
  FloatingPaint(
    this.scale, {
    this.color = Colors.black,
    this.circleColor = Colors.grey,
    this.strokeWidth = 5,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final circlePaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = circleColor;

    final height = size.height / 19;
    final width = size.height / 15;
    final cube = (width / height) * scale;
    final path = Path();
    path.moveTo(0, cube * 2);
    path.lineTo(cube * 8, cube * 2);
    path.arcToPoint(
      Offset(cube * 8, cube * 6),
      radius: const Radius.circular(10),
    );
    path.arcToPoint(Offset(cube * 8, cube * 10),
        radius: const Radius.circular(10), clockwise: false);
    path.arcToPoint(Offset(cube * 8, cube * 14),
        radius: const Radius.circular(10), clockwise: true);
    path.arcToPoint(Offset(cube * 8, cube * 18),
        radius: const Radius.circular(10), clockwise: false);

    path.lineTo(cube * 15, cube * 18);
    // path.close();

    canvas.drawPath(path, linePaint);
    canvas.drawCircle(Offset(cube * 8, cube * 4), cube * 1.2, circlePaint);
    canvas.drawCircle(Offset(cube * 8, cube * 8), cube * 1.2, circlePaint);
    canvas.drawCircle(Offset(cube * 8, cube * 12), cube * 1.2, circlePaint);
    canvas.drawCircle(Offset(cube * 8, cube * 16), cube * 1.2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Future<ImageInfo> getImageInfo(BuildContext context) async {
  AssetImage assetImage = const AssetImage("assets/image.png");
  ImageStream stream =
      assetImage.resolve(createLocalImageConfiguration(context));
  Completer<ImageInfo> completer = Completer();
  //  stream.addListener(ImageStreamListener((ImageInfo imageInfo, _) {
  //     return completer.complete(imageInfo);
  //  }
  stream.addListener(ImageStreamListener((image, synchronousCall) {
    return completer.complete(image);
  }));
  return completer.future;
}
