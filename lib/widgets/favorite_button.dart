import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});
  @override
  State<FavoriteButton> createState() => _FavoriteButton();
}

class _FavoriteButton extends State<FavoriteButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Color?> colorAnimation;
  late final Animation<double> sizeAnimation;
  final animationDuration = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
    sizeAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 20, end: 15), weight: 35),
      TweenSequenceItem(tween: Tween<double>(begin: 15, end: 28), weight: 35),
      TweenSequenceItem(tween: Tween<double>(begin: 28, end: 20), weight: 30)
    ]).animate(_controller);

    colorAnimation = ColorTween(begin: Colors.grey, end: Colors.red).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
  }

  @override
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => IconButton(
        icon: const Icon(Icons.favorite),
        tooltip: 'Increase volume by 10',
        iconSize: sizeAnimation.value,
        color: colorAnimation.value!,
        onPressed: () {
          if (_controller.status == AnimationStatus.dismissed) {
            // If animation is at the start, play it forward
            _controller.forward();
          } else {
            // If animation is ongoing, reverse it
            _controller.reverse();
          }
        },
      ),
    );
  }
}
