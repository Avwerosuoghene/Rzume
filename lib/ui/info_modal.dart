import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/widgets/misc_notifier.dart';

import '../widgets/counter_notifier.dart';
import 'custom_overlay.dart';

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
  late void Function() showOverlayInit;
  bool showDrawer = false;
  late Timer? _timer;
  @override
  void initState() {
    super.initState();
    positionTween = Tween(begin: -100, end: 0);
    durationValue = durationEnum.value;
    _controller = AnimationController(
      duration: durationValue,
      vsync: this,
    );
    positionAnimation = positionTween.animate(_controller);

    // _controller.forward();
    // _counter.startTimer();
  }

  test() {}

  autoMaticToggle() {
    toggleDialog();
    _timer = Timer(const Duration(seconds: 2), () {
      context.read<MiscNotifer>().hideInfoDialog();
      toggleDialog();
    });
  }

  manualToggle() {
    _timer?.cancel();
    toggleDialog();
    context.read<MiscNotifer>().hideInfoDialog();
  }

  toggleDialog() {
    toggleOverlay();

    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void toggleOverlay() {
    showOverlayInit.call();
  }

  @override
  Widget build(BuildContext context) {
    final showDialog = context.watch<MiscNotifer>().overlayVisible;
    if (showDialog) {
      autoMaticToggle();
    }
    return Stack(
      children: <Widget>[
        CustomOverlay(
          builder: (BuildContext context, void Function() showOverlayChild) {
            showOverlayInit = showOverlayChild;
          },
          functionOnTap: manualToggle,
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, positionAnimation.value),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: context.watch<MiscNotifer>().infoColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.watch<MiscNotifer>().dialogMsg,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // });
        ),
      ],
    );
  }
}
