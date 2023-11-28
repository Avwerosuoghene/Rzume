import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  const CustomDrawer(
      {super.key,
      required this.drawerHeight,
      required this.expandDrawer,
      required this.positionController,
      required this.positionAnimation,
      required this.opacityAnimation});

  final double drawerHeight;
  final void Function() expandDrawer;
  final AnimationController positionController;
  final Animation<double> positionAnimation;
  final Animation<double> opacityAnimation;

  @override
  State<CustomDrawer> createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.positionController,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, widget.positionAnimation.value),
        child: Opacity(
          opacity: widget.opacityAnimation.value,
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.red),
              width: MediaQuery.of(context).size.width,
              height: widget.drawerHeight, // Set your desired background color
              child: Center(
                child: ElevatedButton(
                    onPressed: widget.expandDrawer, child: Text('Expand')),
              )),
        ),
      ),
    );
  }
}
