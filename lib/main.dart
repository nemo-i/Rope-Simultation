import 'dart:developer';
import 'dart:math' show pi;
import 'dart:ui';

import 'package:custom_paint/curve.dart';
import 'package:custom_paint/path.dart';
import 'package:custom_paint/sierpinskiCarpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;

import '3dbox_.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  Offset circleOffset = const Offset(800, 70);
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset end = Offset(800, 700);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 700),
      end: end,
    ).animate(_controller)
      ..addListener(() {
        if (_controller.isCompleted) {
          end = Offset(0, 700);
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    bool inRange(Offset offset, Offset end, Offset start) {
      if (offset.dx < start.dx || offset.dx > end.dx) {
        return false;
      }
      // if (offset.dx > end.dx || offset.dy > end.dy) {
      //   return false;
      // }
      return true;
    }

    if (value) {
      _controller.forward();
    } else {
      _controller.stop();
    }
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Simple App'),
        ),
        body: Listener(
          onPointerMove: (event) {
            setState(() {
              circleOffset = event.localPosition;
              value = inRange(
                  circleOffset, const Offset(850, 70), const Offset(750, 70));
              log(value.toString());
            });
          },
          child: Container(
            color: Colors.white,
            width: 800,
            height: 800,
            child: Stack(
              children: [
                CustomPaint(
                  painter: CurveLine(
                      circleOffset:
                          value ? const Offset(800, 70) : circleOffset,
                      lineEnd: const Offset(800, 70)),
                ),
                Transform.translate(
                  offset: const Offset(800 - 30, 30),
                  child: Icon(
                    Icons.lightbulb,
                    size: 80,
                    color: value ? Colors.yellow : Colors.black,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, 45),

                  /// here you can add the electricty supply image
                  child: const CircleAvatar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class PaintPath extends StatelessWidget {
//   const PaintPath({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: LayoutBuilder(builder: (context, constraint) {
//         final cube = (constraint.maxWidth / constraint.maxHeight) * 20;

//         return Stack(
//           children: [
//             CustomPaint(
//               painter: FloatingPaint(cube),
//               size: Size(constraint.maxWidth, constraint.maxHeight),
//             ),
//             Positioned(
//               top: cube * 3.5,
//               right: constraint.maxWidth / 2.2,
//               child: IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.adb,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: constraint.maxHeight / 3,
//               right: constraint.maxWidth / 2.2,
//               child: IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.ad_units,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: constraint.maxHeight / 1.82,
//               right: constraint.maxWidth / 2.2,
//               child: IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.face,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: constraint.maxHeight / 1.33,
//               right: constraint.maxWidth / 2.2,
//               child: IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.gamepad,
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// // class FloatingPaint extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     var paint = Paint()
// //       ..color = const Color(0xFFE7E9F8)
// //       ..strokeWidth = 5
// //       ..style = PaintingStyle.fill
// //       ..strokeWidth = 2;
// //     var linePaint = Paint()
// //       ..color = Colors.red
// //       ..strokeWidth = 5
// //       ..style = PaintingStyle.fill
// //       ..strokeWidth = 2
// //       ..strokeCap = StrokeCap.round;
// //     final wCube = size.width / 8;
// //     // final hCube = size.height / 3;
// //     var linePath = Path();
// //     var path = Path();
// //     path.moveTo(wCube * 2, (wCube * 8) - 15);
// //     path.lineTo(wCube * 6, (wCube * 8) - 15);
// //     path.arcToPoint(Offset(wCube * 6, wCube * 6),
// //         radius: const Radius.circular(10), clockwise: false);
// //     path.arcToPoint(Offset(wCube * 4.8, wCube * 4.8),
// //         radius: const Radius.circular(10), clockwise: false);
// //     path.arcToPoint(Offset(wCube * 2, wCube * 5.5),
// //         radius: const Radius.circular(10), clockwise: false);
// //     path.arcToPoint(Offset(wCube * 2, (wCube * 8) - 15),
// //         radius: const Radius.circular(10), clockwise: false);

// //     path.close();
// //     canvas.drawPath(path, paint);
// //     linePath.moveTo((wCube * 2) - 20, (wCube * 8) - 30);
// //     linePath.arcToPoint(Offset((wCube * 2) + 10, (wCube * 6) - 15),
// //         clockwise: true, radius: const Radius.circular(10));
// //     linePath.arcToPoint(Offset(wCube * 4.5, (wCube * 4.9) - 15),
// //         clockwise: true, radius: const Radius.circular(10));
// //     linePath.arcToPoint(Offset((wCube * 2) + 30, (wCube * 6.30) - 15),
// //         clockwise: false, radius: const Radius.circular(10));
// //     linePath.arcToPoint(Offset((wCube * 2) - 20, (wCube * 7) - 15),
// //         clockwise: false, radius: const Radius.circular(10));

// //     linePath.close();
// //     canvas.drawPath(linePath, linePaint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }
// // class FloatingPaint extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     var paint = Paint()
// //       ..color = const Color(0xFFE7E9F8)
// //       ..strokeWidth = 5
// //       ..style = PaintingStyle.fill
// //       ..strokeWidth = 2;
// //     var linePaint = Paint()
// //       ..color = Colors.red
// //       ..strokeWidth = 5
// //       ..style = PaintingStyle.fill
// //       ..strokeWidth = 2
// //       ..strokeCap = StrokeCap.round;
// //     final wCube = size.width / 8;
// //     // final hCube = size.height / 3;
// //     var linePath = Path();
// //     var path = Path();
// //     path.moveTo(wCube * 2, (wCube * 8) - 15);
// //     path.lineTo(wCube * 6, (wCube * 8) - 15);
// //     path.arcToPoint(Offset(wCube * 6, wCube * 6),
// //         radius: const Radius.circular(10), clockwise: false);
// //     path.arcToPoint(Offset(wCube * 4.8, wCube * 4.8),
// //         radius: const Radius.circular(10), clockwise: false);
// //     path.arcToPoint(Offset(wCube * 2, wCube * 5.5),
// //         radius: const Radius.circular(10), clockwise: false);
// //     path.arcToPoint(Offset(wCube * 2, (wCube * 8) - 15),
// //         radius: const Radius.circular(10), clockwise: false);

// //     path.close();
// //     canvas.drawPath(path, paint);
// //     path.moveTo(wCube * 2, (wCube * 7) - 15);
// //     path.arcToPoint(Offset(wCube * 5, (wCube * 6) - 15),
// //         clockwise: true, radius: const Radius.circular(10));
// //     path.arcToPoint(Offset(wCube * 6, (wCube * 3) - 15),
// //         clockwise: true, radius: const Radius.circular(10));
// //     path.arcToPoint(Offset((wCube * 5) + 20, (wCube * 6) - 15),
// //         clockwise: false, radius: const Radius.circular(10));
// //     path.arcToPoint(Offset((wCube * 2) + 20, (wCube * 7) - 15),
// //         clockwise: false, radius: const Radius.circular(10));

// //     linePath.close();
// //     canvas.drawPath(linePath, linePaint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }
// // class FloatingPaint extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     var paint = Paint()
// //       ..color = Colors.teal
// //       ..strokeWidth = 5
// //       ..style = PaintingStyle.fill;

// //     var path = Path();
// //     path.moveTo(30, size.height / 2);
// //     path.lineTo(size.width, size.height / 2);
// //     path.arcToPoint(
// //       Offset(size.width, size.height),
// //       radius: const Radius.circular(10),
// //     );
// //     path.lineTo(size.width - 100, size.height);
// //     path.arcToPoint(
// //       Offset(size.width - 100, size.height - 100),
// //       radius: const Radius.circular(50),
// //     );
// //     path.arcToPoint(
// //       Offset(size.width, size.height - 150),
// //       radius: const Radius.circular(50),
// //       clockwise: false,
// //     );
// //     path.lineTo(30, size.height - 150);
// //     path.arcToPoint(
// //       Offset(30, size.height / 2),
// //       radius: const Radius.circular(50),
// //       clockwise: true,
// //     );
// //     path.close();
// //     canvas.drawPath(path, paint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }

// class RemoteControlCenterButton extends StatelessWidget {
//   const RemoteControlCenterButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const Color iconColor = Color(0xFFC1C4C7);
//     return Stack(
//       children: [
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: CustomPaint(
//               painter: RRCurv(
//                 arcRaduis: .2,
//                 // color: Colors.grey.shade400,
//                 strokeColor: const Color(0xFF1E1E1F),
//               ),
//               // size: const Size(200, 200),
//               child: SizedBox(
//                 height: 300,
//                 width: 300,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           CupertinoIcons.chevron_up,
//                           color: iconColor,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           CupertinoIcons.chevron_down,
//                           color: iconColor,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           CupertinoIcons.chevron_right,
//                           color: iconColor,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           CupertinoIcons.chevron_left,
//                           color: iconColor,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: SizedBox(
//                         width: 60,
//                         height: 60,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Text(
//                             'OK',
//                             style: TextStyle(
//                               fontSize: 27,
//                               color: iconColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class RRCurv extends CustomPainter {
//   final Color color;
//   final double strokeWidth;
//   final double radius;
//   final Color strokeColor;
//   final double arcRaduis;

//   RRCurv({
//     this.color = Colors.black54,
//     this.strokeWidth = 2.5,
//     this.radius = 1.7,
//     this.strokeColor = Colors.black,
//     this.arcRaduis = 10,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//     final path = Path();
//     final cube = size.width / 3;
//     final a = Offset(cube, cube);
//     final b = Offset(cube, 0);
//     final c = Offset(cube * 2, 0);
//     final d = Offset(cube * 2, cube);
//     final e = Offset(cube * 3, cube);
//     final f = Offset(cube * 3, cube * 2);
//     final g = Offset(cube * 2, cube * 2);
//     final h = Offset(cube * 2, cube * 3);
//     final i = Offset(cube, cube * 3);
//     final j = Offset(cube, cube * 2);
//     final k = Offset(0, cube * 2);
//     final l = Offset(0, cube);
//     final arcR = Radius.circular(arcRaduis);
//     path.moveTo(l.dx, l.dy);
//     path.quadraticBezierTo(a.dx, a.dy, b.dx, b.dy);
//     path.arcToPoint(
//       c,
//       clockwise: true,
//       radius: arcR,
//     );
//     path.quadraticBezierTo(d.dx, d.dy, e.dx, e.dy);
//     path.arcToPoint(
//       f,
//       clockwise: true,
//       radius: arcR,
//     );
//     path.quadraticBezierTo(g.dx, g.dy, h.dx, h.dy);
//     path.arcToPoint(
//       i,
//       clockwise: true,
//       radius: arcR,
//     );
//     path.quadraticBezierTo(j.dx, j.dy, k.dx, k.dy);
//     path.arcToPoint(
//       l,
//       clockwise: true,
//       radius: arcR,
//     );

//     path.close();
//     canvas.drawPath(path, paint);
//     canvas.drawCircle(
//       Offset(cube * 1.5, cube * 1.5),
//       cube / radius,
//       paint
//         ..style = PaintingStyle.stroke
//         ..color = strokeColor
//         ..strokeWidth = strokeWidth,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class BBCurve extends CustomPainter {
//   final Color color;
//   BBCurve(this.color);
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = color;
//     // canvas.drawLine(Offset.zero, Offset(size.height, size.width), paint);
//     final path = Path();
//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//         size.width / 5, size.height / 3, size.width / 2, size.height / 1.5);
//     path.lineTo(size.width / 2, size.height / 1.5);
//     path.quadraticBezierTo(size.width / 1.3, size.height, size.width, 0);
//     path.close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// import 'package:custom_paint/custom_arc.dart';
// import 'package:flutter/material.dart';

// void main(List<String> args) {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Simple App'),
//         ),
//         body: Column(
//           children: [CustomArc()],
//         ),
//       ),
//     );
//   }
// }
