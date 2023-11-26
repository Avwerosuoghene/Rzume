import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class BellIcon extends StatefulWidget {
  @override
  const BellIcon({super.key});

  State<BellIcon> createState() {
    return _BellIcon();
  }
}

class _BellIcon extends State<BellIcon> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> rotateAnimation;
  final animationDuration = const Duration(seconds: 1);
  Timer _timer = Timer(Duration.zero, () {});
  var countdownDuration = const Duration(seconds: 4);

  int counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    rotateAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.2), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: -0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: 0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: -0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: 0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: -0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: 0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: -0.2, end: 0), weight: 17),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.2), weight: 16),
      TweenSequenceItem(tween: Tween<double>(begin: 0.2, end: 0), weight: 17),
    ]).animate(_controller);

    _controller.forward();
    bellNotifier();
  }

  bellNotifier() {
    counter = 5;

    _timer = Timer.periodic(
      countdownDuration,
      (Timer timer) {
        print(counter);
        if (counter == 0) {
          timer.cancel();
        } else {
          if (_controller.status == AnimationStatus.dismissed) {
            // If animation is at the start, play it forward
            _controller.forward();
          } else {
            // If animation is ongoing, reverse it
            _controller.reverse();
          }
          counter--;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.rotate(
              angle: rotateAnimation.value * math.pi,
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  'assets/icons/bell.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ));
  }
}
