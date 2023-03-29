import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_test_app/egg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EasterCard(),
    );
  }
}

class SineCurve extends Curve {
  final double count;

  const SineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5;
  }
}

class EasterCard extends StatefulWidget {
  const EasterCard({Key? key}) : super(key: key);

  @override
  EasterCardState createState() => EasterCardState();
}

class EasterCardState extends State<EasterCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;

  late Animation<double> _eggAnimation;
  late Animation<Offset> _bunnyAnimation;
  late Animation<Offset> _cloudAnimation;

  late Animation<double> _textSize;
  late Animation<double> _textSize2;
  late Animation<double> _textPadding;
  late Animation<double> _textPadding2;

  var _showText = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _controller4 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _eggAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.linear,
    ));

    _bunnyAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.35),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: const SineCurve(),
    ));

    _cloudAnimation = Tween<Offset>(
      begin: const Offset(5.0, 0.0),
      end: const Offset(-10.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _textSize = Tween<double>(
      begin: 40.0,
      end: 60.0,
    ).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );

    _textSize2 = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    _textPadding = Tween<double>(
      begin: 90.0,
      end: 110.0,
    ).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: const Interval(0.25, 0.5, curve: Curves.easeIn),
      ),
    );

    _textPadding2 = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: const Interval(0.5, 0.75, curve: Curves.easeIn),
      ),
    );

    _controller.repeat();
    _controller2.repeat();
    _controller3.repeat();
    _controller4.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 250,
              left: 150,
              child: Egg(
                animation: _eggAnimation,
                emoji: '🐣',
                colors: const [
                  Colors.red,
                  Colors.yellow,
                ],
              ),
            ),
            Positioned(
              top: 300,
              left: 100,
              child: Egg(
                animation: _eggAnimation,
                emoji: '🐰',
                colors: const [
                  Colors.green,
                  Colors.yellow,
                ],
              ),
            ),
            Positioned(
              top: 350,
              left: 50,
              child: Egg(
                animation: _eggAnimation,
                emoji: '🐇',
                colors: const [
                  Colors.blue,
                  Colors.pink,
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 50,
              child: AnimatedBuilder(
                animation: _cloudAnimation,
                builder: (BuildContext context, Widget? child) {
                  return FractionalTranslation(
                    translation: _cloudAnimation.value,
                    child: child!,
                  );
                },
                child: const Icon(
                  Icons.cloud,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),
            Positioned(
              top: 220,
              right: 0,
              child: AnimatedBuilder(
                animation: _bunnyAnimation,
                builder: (BuildContext context, Widget? child) {
                  return FractionalTranslation(
                    translation: _bunnyAnimation.value,
                    child: child!,
                  );
                },
                child: Image.asset(
                  "assets/images/bunny.png",
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: _textPadding.value - _textPadding2.value),
                  child: AnimatedAlign(
                    duration: const Duration(seconds: 1),
                    alignment: _showText
                        ? Alignment.topCenter
                        : const Alignment(0, 10),
                    child: Positioned(
                      child: Text(
                        "Happy Easter!",
                        style: TextStyle(
                          fontFamily: 'Satisfy',
                          color: Colors.white,
                          fontSize: _textSize.value - _textSize2.value,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _showText = !_showText;
                      });
                    },
                    child: const Text(
                      "Press me!",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Satisfy',
                          color: Colors.yellowAccent),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
