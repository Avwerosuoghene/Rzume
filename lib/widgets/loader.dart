import 'dart:ui';

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeIn,
  // );

  late final Animation<double> _animation = Tween<double>(
    begin: 0.5, // Start opacity from 0.2 instead of 0
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  Widget build(BuildContext context) {
    return
        // height: 20000,
        // width: 20000,

        BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Center(
        child: FadeTransition(
          opacity: _animation,
          child: SizedBox(
            width: 180,
            height: 180,
            child: Image.asset(
              'assets/icons/loader_img.png',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
