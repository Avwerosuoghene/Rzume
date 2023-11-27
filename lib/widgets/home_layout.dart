import 'dart:ui';

import 'package:flutter/material.dart';

class HomePageLayout extends StatefulWidget {
  @override
  const HomePageLayout({super.key});

  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
}

class _HomePageLayoutState extends State<HomePageLayout>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> positionAnimation;
  late final Animation<double> positionAnimation2;
  late final Tween<double> positionTween;
  late final Animation<double> opacityAnimation;
  final animationDuration = const Duration(milliseconds: 500);
  bool showOverlay = false;
  final double aspectRatio =
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  Size screenSize =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  late double screenHeight;
  double drawerHeight = 200;
  late final Animation<double> activePositionAnimation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    screenHeight = screenSize.height / aspectRatio;
    print('screen height is + ${screenHeight}');
    positionTween = Tween(begin: screenHeight, end: screenHeight - 200);
    positionAnimation = positionTween.animate(_controller);
    activePositionAnimation = positionAnimation;

    positionAnimation2 =
        Tween<double>(begin: screenHeight - 200, end: screenHeight - 400)
            .animate(_controller);

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  toggleDrawer() {
    print('xxxxxxxxxxxxx');
    print('toggle activated');
    hideOverlay();
    showDrawer();
  }

  void hideOverlay() {
    if (showOverlay == true) {
      setState(() {
        showOverlay = false;
      });
    } else {
      setState(() {
        showOverlay = true;
      });
    }
  }

  void showDrawer() {
    print(_controller.status);
    if (_controller.status == AnimationStatus.dismissed) {
      // If animation is at the start, play it forward
      _controller.forward();
    } else {
      // If animation is ongoing, reverse it
      _controller.reverse();
    }
  }

  void expandDrawer() {
    // print('xccxxcxcxcxcxcxcxcxcx');
    // positionTween
    //   ..begin = screenHeight - 200
    //   ..end = screenHeight - 400;

    // // _controller.reset();
    // positionAnimation = positionTween.animate(_controller);
    setState(() {
      drawerHeight = 400;
      activePositionAnimation = positionAnimation2;
    });

    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    OverlayEntry? _overlayEntry;

    return Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue, // Set your desired background color
            child: Center(
              child: FilledButton(
                  onPressed: toggleDrawer, child: Text('Activate')),
            )),
        // if (showOverlay)
        //   GestureDetector(
        //     onTap: toggleDrawer,
        //     onTap: (){
        //  if (_controller.isDismissed) {
        // hideOverlay();
        // }},
        //     child: AnimatedBuilder(
        //       animation: _controller,
        //       builder: (context, child) => Opacity(
        //         opacity: opacityAnimation.value,
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        //           child: Container(
        //             color: Colors.black.withOpacity(0.5),
        //             child: Center(
        //               child: SizedBox(width: 10, height: 10),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, activePositionAnimation.value),
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
        ),
        // Positioned(
        //   bottom: 0,
        //   child:
        // ),
      ],
    );
  }
}
