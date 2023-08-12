import 'package:flutter/material.dart';

import '../model/misc-type.dart';

class StartScreenMessage extends StatelessWidget {
  const StartScreenMessage({super.key, required this.messageProps});

  final StartMessage messageProps;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        messageProps.image,
        width: 188,
      ),
      // const SizedBox(
      //   height: 40,
      // ),
      Text(messageProps.title_1,
          style: Theme.of(context).textTheme.titleSmall!),
      if (messageProps.title_2 != null)
        Text(
          messageProps.title_2!,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 1.5),
        ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: 300,
        child: Text(
          textAlign: TextAlign.center,
          messageProps.para,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black26),
        ),
      ),
    ]);
  }
}
