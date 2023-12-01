import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/widgets/misc_notifier.dart';

import '../widgets/counter_notifier.dart';

class Infomodal extends StatefulWidget {
  const Infomodal({super.key});

  @override
  State<Infomodal> createState() => _InfomodalState();
}

class _InfomodalState extends State<Infomodal> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Tween<double> positionTween;
  late final Animation<double> positionAnimation;
  AnimationDuration durationEnum = AnimationDuration.short;
  late Duration durationValue;
  final MiscNotifer _miscNotifier = MiscNotifer();
  final CounterNotifier _counter = CounterNotifier();
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    positionTween = Tween(begin: 20.0, end: 100.0);
    durationValue = durationEnum.value;
    _controller = AnimationController(
      duration: durationValue,
      vsync: this,
    );
    positionAnimation = positionTween.animate(_controller);

    // _controller.forward();
    // _counter.startTimer();
  }

  showDialog() {
    _controller.forward();
  }

  hideDialog() {
    // _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final testValue = context.watch<MiscNotifer>().test;
    if (testValue == "newValue") {
      showDialog();
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        height: positionAnimation.value,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Text(
          context.watch<MiscNotifer>().test,
          style: TextStyle(color: Colors.white),
        ),
      ),
      // });
    );
  }
}
