import 'package:flutter/material.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CusDropDownButton extends StatefulWidget {
  const CusDropDownButton({
    required this.onSelectChangeFunction,
    required this.selectionHint,
    required this.selectionItems,
    this.roundnessDegree = Roundness.partial,
    Key? key,
  }) : super(key: key);

  static final GlobalKey<CusDropDownButtonState> globalKey = GlobalKey();

  final void Function(String value) onSelectChangeFunction;
  final Roundness? roundnessDegree;
  final String selectionHint;
  final List<String> selectionItems;

  @override
  State<CusDropDownButton> createState() => CusDropDownButtonState();
}

class CusDropDownButtonState extends State<CusDropDownButton> {
  late List<String> selectionItems;

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void resetForm() {
    print('reset form called');
    selectedValue = null;
  }

  @override
  Widget build(BuildContext context) {
    final roundness = widget.roundnessDegree!.value;

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(roundness),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,

          hint: Text(
            widget.selectionHint,
            style: Theme.of(context).inputDecorationTheme.hintStyle,
          ),
          items: widget.selectionItems
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                selectedValue = value;
                widget.onSelectChangeFunction(value);
              }
            });
          },
          buttonStyleData: ButtonStyleData(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundness),
                border: Border.all(
                  color: const Color.fromARGB(108, 165, 165, 165),
                  width: 1,
                ),
              )),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase());
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
