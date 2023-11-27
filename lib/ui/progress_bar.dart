import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, int? activeIndex})
      : activeIndex = activeIndex ?? 0;
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 25,
            height: 3,
            decoration: BoxDecoration(
                color: activeIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                borderRadius: BorderRadius.circular(5)),
          ),
          const SizedBox(
            width: 2,
          ),
          Container(
            width: 15,
            height: 3,
            decoration: BoxDecoration(
                color: activeIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : const Color.fromARGB(255, 192, 192, 192),
                borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }
}
