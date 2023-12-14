import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {super.key,
      required this.dialogTitle,
      required this.dialogBody,
      required this.dialogIcon});

  final String dialogTitle;
  final String dialogIcon;
  final String dialogBody;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      surfaceTintColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Adjust the border radius here
      ),
      children: [
        Column(children: [
          Image.asset(
            dialogIcon,
            width: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(dialogTitle,
              style: Theme.of(context).textTheme.titleSmall!,
              textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: Text(
              dialogBody,
              style: Theme.of(context).textTheme.bodyMedium!,
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ],
    );
  }
}
