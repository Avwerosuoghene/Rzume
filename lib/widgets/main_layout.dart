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

class _MainLayoutState extends State<MainLayout> {
  late void Function() showDrawerInit;

  late void Function() showOverlayInit;

  bool showOverlay = false;

  @override
  void initState() {
    super.initState();
  }

  toggleDrawer() {
    hideOverlay();
    showDrawer();
  }

  void hideOverlay() {
    setState(() {
      showOverlay = !showOverlay;
    });
    showOverlayInit.call();
  }

  void showDrawer() {
    showDrawerInit.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MainSubLayout(
          toggleDrawer: toggleDrawer,
        ),
   
          CustomOverlay(
            builder: (BuildContext context, void Function() showOverlayChild) {
              showOverlayInit = showOverlayChild;
            },
            functionOnTap: toggleDrawer,
          ),
        CustomDrawer(
          builder: (BuildContext context, void Function() showDrawerChild) {
            showDrawerInit = showDrawerChild;
          },
        )
      ],
    );
  }
}
