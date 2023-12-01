import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/enums.dart';
import '../ui/custom_drawer.dart';
import '../ui/custom_overlay.dart';
import 'main_sub_layout.dart';

class MainLayout extends StatefulWidget {
  @override
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _controller2;
  late final Animation<double> positionAnimation;
  late Tween<double> positionTween;
  late final Animation<double> opacityAnimation;
  late bool showOverlay;
  final double aspectRatio =
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  Size screenSize =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  late double screenHeight;
  double drawerHeight = 200;
  AnimationDuration durationEnum = AnimationDuration.short;
  late Duration durationValue;
  late void Function() showDrawerInit;

  late void Function() showOverlayInit;

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
    showOverlay = false;

    screenHeight = screenSize.height / aspectRatio;
    positionTween = Tween(begin: screenHeight, end: screenHeight - 200);
    positionAnimation = positionTween.animate(_controller)..addListener(() {});

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller2);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  toggleDrawer() {
    hideOverlay();
    showDrawer();
  }

  void hideOverlay() {
    showOverlayInit.call();
    // if (showOverlay == true) {
    //   setState(() {
    //     showOverlay = false;
    //   });
    // } else {
    //   setState(() {
    //     showOverlay = true;
    //   });
    // }
  }

  void showDrawer() {
    showDrawerInit.call();
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
    return Stack(
      children: <Widget>[
        MainSubLayout(
          toggleDrawer: toggleDrawer,
        ),
        // if (showOverlay)
        CustomOverlay(
            builder: (BuildContext context, void Function() showOverlayChild) {
              showOverlayInit = showOverlayChild;
            },
            functionOnTap: toggleDrawer,
            dialogVisibilityStatus: showOverlay),
        // if (showOverlay)
        CustomDrawer(
          builder: (BuildContext context, void Function() showDrawerChild) {
            showDrawerInit = showDrawerChild;
          },
          drawerHeight: drawerHeight,
          expandDrawer: expandDrawer,
          dialogVisibilityStatus: showOverlay,
          positionController: _controller,
          positionAnimation: positionAnimation,
          opacityAnimation: opacityAnimation,
        )
      ],
    );
  }
}
