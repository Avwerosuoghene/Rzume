import 'package:flutter/material.dart';
import 'package:rzume/config/environment.dart';

class MainSubLayout extends StatefulWidget {
  @override
  const MainSubLayout({super.key, required this.toggleDrawer});

  final void Function() toggleDrawer;

  @override
  State<MainSubLayout> createState() => _MainSubLayout();
}

class _MainSubLayout extends State<MainSubLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue, // Set your desired background color
        child: Center(
          child: FilledButton(
              onPressed: widget.toggleDrawer, child: Text(Environment.apiUrl)),
        ));
  }
}
