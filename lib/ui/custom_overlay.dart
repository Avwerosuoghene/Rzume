import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/enums.dart';
import '../model/misc-type.dart';

class CustomOverlay extends StatefulWidget {
  @override
  const CustomOverlay(
      {super.key, required this.functionOnTap, required this.builder});
  final MyBuilder builder;

  final void Function() functionOnTap;

  @override
  State<CustomOverlay> createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> opacityAnimation;
  AnimationDuration durationEnum = AnimationDuration.short;
  late Duration durationValue;
  bool showOverlay = false;

  @override
  void initState() {
    super.initState();
    durationValue = durationEnum.value;
    _controller = AnimationController(
      duration: durationValue,
      vsync: this,
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  showDialog() {
    setState(() {
      showOverlay = true;
    });
    _controller.forward();
  }

  hideDialog() {
    setState(() {
      showOverlay = false;
    });
    _controller.reverse();
  }

  toggleOverlay() {
    if (_controller.status == AnimationStatus.dismissed) {
      showDialog();
    } else {
      hideDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, toggleOverlay);

    Widget overlayContent = const SizedBox(
      width: 0,
      height: 0,
    );

    if (showOverlay == true) {
      overlayContent = GestureDetector(
        onTap: widget.functionOnTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Opacity(
            opacity: opacityAnimation.value,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: SizedBox(width: 10, height: 10),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return overlayContent;
  }
}
