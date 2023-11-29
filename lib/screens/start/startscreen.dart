import 'package:flutter/material.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import '../../model/data.dart';
import '../../ui/progress_bar.dart';
import '../../widgets/horizontal-list.dart';
import '../../ui/loader.dart';
import '../../widgets/start_screen_message.dart';

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
      // showDialog<String>(
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (BuildContext context) {
      //       return Container(
      //         color: const Color.fromARGB(133, 0, 0, 0),
      //         child: CustomLoader(),
      //       );

      //       // width: 20,
      //       // height: 20,
      //     });

      Navigator.pushNamed(context, '/signin');
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
