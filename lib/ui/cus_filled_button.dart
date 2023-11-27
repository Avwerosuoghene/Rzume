import 'package:flutter/material.dart';

class CusFilledButton extends StatelessWidget {
  const CusFilledButton(
      {super.key,
      required this.onPressedFunction,
      required this.buttonText,
      required this.buttonWidth});

  final void Function() onPressedFunction;
  final String buttonText;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: buttonWidth,
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(41),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.background),
        ),
        onPressed: onPressedFunction,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
