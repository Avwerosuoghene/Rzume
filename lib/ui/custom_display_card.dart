import 'package:flutter/material.dart';
import 'package:rzume/model/enums.dart';

class CustomDisplayCard extends StatelessWidget {
  const CustomDisplayCard(
      {super.key,
      this.roundnessDegree = Roundness.partial,
      required this.itemIndex,
      required this.cardContent,
      required this.itemImage,
      required this.deleteFunction});

  final int itemIndex;
  final String itemImage;

  final Roundness? roundnessDegree;
  final Widget cardContent;
  final void Function(int itemIndex) deleteFunction;

  @override
  Widget build(BuildContext context) {
    final roundness = roundnessDegree!.value;

    deleteActiveitem() {
      deleteFunction(itemIndex);
    }

    return Container(
        width: double.infinity,
        height: 86,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(roundness),
          border: Border.all(
            color: const Color.fromARGB(
                108, 165, 165, 165), // Set your desired border color here
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  // color: Color.fromRGBO(247, 247, 247, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Image.asset(
                itemImage,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            cardContent,
            const Spacer(),
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                icon: const Icon(Icons.delete_outline),
                iconSize: 20,
                onPressed: deleteActiveitem,
              ),
            ),
          ],
        ));
  }
}
