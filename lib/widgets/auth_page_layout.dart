import 'package:flutter/material.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout(
      {super.key,
      required this.pageContent,
      this.footerText,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.backgroundColor = Colors.white,
      this.showBacknav = true});

  final Color backgroundColor;

  final Widget pageContent;
  final Widget? footerText;
  final bool showBacknav;
  final dynamic crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    double availableHeight = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        leading: showBacknav
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(0, 0, 0, 0.70),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          width: MediaQuery.of(context).size.width,
          height: availableHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                SizedBox(
                  child: ListView(children: [pageContent]),
                  height: MediaQuery.of(context).size.height - 250,
                ),
                Spacer(),
                if (footerText != null)
                  Column(
                    children: [
                      footerText!,
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/icons/rzume_logo_dark.png',
                    width: 71,
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
