import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList(
      {super.key,
      required this.padding,
      required this.scrollController,
      required this.data});

  final int padding;
  final ScrollController scrollController;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SizedBox(
              width: MediaQuery.of(context).size.width - padding,
              child: data[index]);
        },

        //  ),
      ),
    );
  }
}
