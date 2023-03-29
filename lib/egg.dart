import 'dart:math';
import 'package:flutter/material.dart';

class Egg extends StatelessWidget {
  const Egg(
      {Key? key,
      required this.animation,
      required this.emoji,
      required this.colors})
      : super(key: key);

  final Animation<double> animation;
  final String emoji;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: animation.value * 2 * pi,
          child: child!,
        );
      },
      child: Container(
        width: 55,
        height: 75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.elliptical(75 / 2, 75 / 2),
            bottomRight: Radius.elliptical(75 / 2, 75 / 2),
            topLeft: Radius.elliptical(75 * 0.5, 75 * 0.65),
            topRight: Radius.elliptical(75 * 0.5, 75 * 0.65),
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
