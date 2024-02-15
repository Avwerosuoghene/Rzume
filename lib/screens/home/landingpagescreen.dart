import 'package:flutter/material.dart';
import 'package:rzume/model/enums.dart';

import '../../model/user_data.dart';
import '../../model/misc-type.dart';
import '../../ui/custom_form_field.dart';
import '../../ui/bell_icon.dart';
import '../../ui/favorite_button.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<LandingPageScreen> createState() {
    return _LandingPageScreen();
  }
}

class _LandingPageScreen extends State<LandingPageScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  );

  final ICustomFormField searchField = formData.search;
  bool likeActive = false;
  Color likeButtonColor = const Color.fromARGB(179, 82, 77, 77);

  String? searchInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    ;
    return null;
  }

  late final AnimationController rotateController = AnimationController(
    duration: const Duration(seconds: 1),
    reverseDuration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> rotateAnimation;
  late final AnimationController scaleController = AnimationController(
    duration: const Duration(seconds: 10),
    reverseDuration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    rotateAnimation =
        CurvedAnimation(parent: rotateController, curve: Curves.linear);
    scaleAnimation =
        CurvedAnimation(parent: scaleController, curve: Curves.linear);
    scaleController.repeat(
      min: 0,
      max: 1,
      period: Duration(seconds: 2),
      reverse: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onLikeActivated() {
    if (likeActive == false) {
      likeActive = true;
      setState(() {
        likeButtonColor = Colors.red;
      });
    } else {
      likeActive = false;
      setState(() {
        likeButtonColor = const Color.fromARGB(179, 82, 77, 77);
        ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        automaticallyImplyLeading: false,
      ),
      //
      body: Container(
        color: Theme.of(context).colorScheme.onBackground,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              height: 45,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // SizedBox(
                //     width: 245,
                //     child:
                Expanded(
                  child: CustomFormField(
                    formHint: searchField.formHint,
                    formLabel: searchField.formLabel,
                    formPrefixIcon: searchField.formPrefixIcon,
                    inputValue: searchField.enteredInputSet,
                    showSuffixIcon: searchField.showSuffixIcon,
                    validatorFunction: searchInputValidator,
                    keyboardType: searchField.keyboardType,
                    onChangeEvent: (value) {},
                    roundnessDegree: Roundness.full,
                    showValidator: false,
                  ),
                ),
                // ),
                const FavoriteButton(),
                const BellIcon()
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
