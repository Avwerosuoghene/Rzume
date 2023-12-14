import 'package:flutter/material.dart';

import '../model/enums.dart';
import '../model/misc-type.dart';

class CustomDrawer extends StatefulWidget {
  @override
  const CustomDrawer(
      {super.key,
      required this.builder});

  final MyBuilder builder;


  @override
  State<CustomDrawer> createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _controller2;
  late final Animation<double> positionAnimation;
  late Tween<double> positionTween;
  late final Animation<double> opacityAnimation;
  final double aspectRatio =
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  Size screenSize =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  late double screenHeight;
  double drawerHeight = 200;
  AnimationDuration durationEnum = AnimationDuration.short;
  late Duration durationValue;



  @override
  void initState() {
    durationValue = durationEnum.value;

    super.initState();

    _controller = AnimationController(
      duration: durationValue,
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: durationValue,
      vsync: this,
    );
    screenHeight = screenSize.height / aspectRatio;
    positionTween = Tween(begin: screenHeight, end: screenHeight - 200);
    positionAnimation = positionTween.animate(_controller)..addListener(() {});
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller2);
  }

  hideDrawer() {
    _controller.reverse();
  }

  void showDrawer() {
    if (_controller.status == AnimationStatus.dismissed) {
      // If animation is at the start, play it forward
      _controller.forward();
      _controller2.forward();
    } else {
      // If animation is ongoing, reverse it

      _controller.reverse().whenComplete(() => {
            setState(() {
              drawerHeight = 200;
              _controller.reset();
              positionTween.begin = screenHeight;
              positionTween.end = screenHeight - 200;
            })
          });
      _controller2.reverse();
    }
  }

  void expandDrawer() {
    if (drawerHeight != 400) {
      _controller.reset();
      positionTween.begin = screenHeight - 200;

      positionTween.end = screenHeight - 400;
      _controller.forward();

      setState(() {
        drawerHeight = 400;
      });

      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.dialogVisibilityStatus == true) {
    //   showDrawer();
    // } else {
    //   hideDrawer();
    // }

    widget.builder.call(context, showDrawer);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, positionAnimation.value),
        child: Opacity(
          opacity: opacityAnimation.value,
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.red),
              width: MediaQuery.of(context).size.width,
              height: drawerHeight, // Set your desired background color
              child: Center(
                child: ElevatedButton(
                    onPressed: expandDrawer, child: Text('Expand')),
              )),
        ),
      ),
    );
  }
}
