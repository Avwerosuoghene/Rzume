import 'package:flutter/material.dart';
import 'package:rzume/ui/cus-filled-button.dart';
import '../../model/data.dart';
import '../../ui/progress-bar.dart';
import '../../widgets/horizontal-list.dart';
import '../../widgets/start-screen-message.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int currentIndex = 0;
  late BuildContext myContext;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width - 32;

    void scrollListener() {
      setState(() {
        currentIndex = scrollController.offset ~/ itemWidth;
      });
    }

    void navigateToAuthScreen() {
      Navigator.pushNamed(context, '/signup');
    }

    scrollController.addListener(scrollListener);

    List<Widget> messages = [
      StartScreenMessage(messageProps: screenData[0]),
      StartScreenMessage(messageProps: screenData[1])
    ];

    return Center(
        child: Padding(
      padding: const EdgeInsets.all(16),

      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HorizontalList(
              data: messages,
              padding: 32,
              scrollController: scrollController,
            ),
            const SizedBox(
              height: 30,
            ),
            ProgressBar(activeIndex: currentIndex),
            const SizedBox(
              height: 30,
            ),
            // SizedBox(
            // width: double.infinity,
            CusFilledButton(
              buttonWidth: double.infinity,
              buttonText: 'Get Started',
              onPressedFunction: navigateToAuthScreen,
            ),
            // ),
          ],
        ),
      ),
      // ),
    ));
  }
}
