import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rzume/widgets/misc_notifier.dart';

import '../ui/custom_drawer.dart';
import '../ui/custom_overlay.dart';

class InfoOverlayCaller extends StatefulWidget {
  const InfoOverlayCaller({super.key});

  @override
  State<InfoOverlayCaller> createState() => _InfoOverlayCaller();
}

class _InfoOverlayCaller extends State<InfoOverlayCaller> {
  late void Function() showOverlayInit;

  @override
  void initState() {
    super.initState();
  }

  void showOverlay() {
    showOverlayInit.call();
  }

  @override
  Widget build(BuildContext context) {
    final overlayTriggered = context.watch<MiscNotifer>().overlayVisible;
    if (overlayTriggered) {
      showOverlay();
    }
    return CustomOverlay(
      builder: (BuildContext context, void Function() showOverlayChild) {
        showOverlayInit = showOverlayChild;
      },
      functionOnTap: showOverlay,
    );
  }
}
