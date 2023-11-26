import 'package:flutter/material.dart';

class CusOutlineButton extends StatelessWidget {
  CusOutlineButton(
      {super.key,
      required this.icon,
      required this.buttonText,
      required this.color,
      required this.onPressedFunction});

  final String icon;
  final String buttonText;
  final Color color;
  final void Function() onPressedFunction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressedFunction,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(41),
          )),
          side: MaterialStateProperty.all(
            const BorderSide(
                color: Color.fromARGB(108, 165, 165, 165),
                width: 1.0,
                style: BorderStyle.solid),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              icon,
              width: 60,
            ),
            Text(
              buttonText,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
            ),
          ]),
        ),
      ),
    );
  }
}
