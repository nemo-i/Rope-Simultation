import 'dart:math' show pi, cos, sin;

import 'package:custom_paint/navigation_painter.dart';
import 'package:flutter/material.dart';

class CustomArc extends StatefulWidget {
  const CustomArc({super.key});

  @override
  State<CustomArc> createState() => _CustomArcState();
}

class _CustomArcState extends State<CustomArc>
    with SingleTickerProviderStateMixin {
  final double radius = 200;
  final double buttonRadius = 30;
  late final AnimationController _controller;
  late final Animation<int> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween<int>(begin: 1, end: 4).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              foregroundPainter: NavigationPainter(_animation.value),
              size: const Size(400, 400),
            );
          },
        ),
        Positioned(
          top: 120,
          left: 35,
          child: Button(
            onPressed: () {},
            iconData: Icons.people,
            title: 'Peoples',
          ),
        ),
        Positioned(
          left: 120,
          top: 50,
          child: Button(
            onPressed: () {},
            iconData: Icons.receipt,
            title: 'Recieve',
          ),
        ),
        Positioned(
          right: 120,
          top: 50,
          child: Button(
            onPressed: () {},
            iconData: Icons.send,
            title: 'Send',
          ),
        ),
        Positioned(
          top: 120,
          right: 35,
          child: Button(
            onPressed: () {},
            iconData: Icons.store,
            title: 'Deposite',
          ),
        ),
        Positioned(
          top: 130,
          left: 175,
          child: Button(
            onPressed: () {},
            iconData: Icons.qr_code_2,
            title: 'QR Pay',
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.title,
  });
  final Function() onPressed;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
