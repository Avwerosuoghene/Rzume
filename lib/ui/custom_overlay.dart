import 'dart:ui';

import 'package:flutter/material.dart';

class CustomOverlay extends StatelessWidget {
  @override
  const CustomOverlay(
      {super.key,
      required this.toggleDrawer,
      required this.opacityAnimation,
      required this.controller});

  final void Function() toggleDrawer;
  final AnimationController controller;
  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDrawer,
      child: AnimatedBuilder(
        animation: controller,
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
}
