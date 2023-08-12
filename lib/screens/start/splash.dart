import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 1.0],
          colors: [
            Color.fromARGB(255, 58, 177, 229),
            Color.fromARGB(255, 13, 58, 100),
          ],
        ),
      ),
      child: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        // axisAlignment: -1,
        child: Center(
          child: Image.asset(
            'assets/icons/rzume_logo.png',
            width: 217,
          ),
        ),
      ),
      // ),
    );
  }
}
