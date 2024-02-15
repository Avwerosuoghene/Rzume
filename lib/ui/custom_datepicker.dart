import 'package:flutter/material.dart';
import 'package:rzume/model/enums.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    required this.onSelectDateFunction,
    this.roundnessDegree = Roundness.partial,
    Key? key,
  }) : super(key: key);
  static final GlobalKey<CustomDatePickerState> globalKey = GlobalKey();

  final void Function(DateTime? value) onSelectDateFunction;
  final Roundness? roundnessDegree;

  @override
  State<CustomDatePicker> createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  final TextEditingController _dateController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void resetDate() {
    setState(() {
      _dateController.text = "";
      DateTime? selectedDate;
      widget.onSelectDateFunction(selectedDate);
    });
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 50 * 365)),
      lastDate: DateTime.now(),
      barrierColor: Colors.white,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context)
                .colorScheme
                .primary, // Change the header background color// Change the text color
            colorScheme: ColorScheme.light(
              primary: Theme.of(context)
                  .colorScheme
                  .primary, // Change the selection color
            ),
            // buttonTheme: ButtonThemeData(
            //   textTheme: ButtonTextTheme.primary,
            // ),
          ),
          child: child!,
        );
      },
    );

    if (_picked != null) {
      setState(() {
        DateTime selectedDate;
        _dateController.text = _picked.toString().split(" ")[0];
        selectedDate = _picked;
        widget.onSelectDateFunction(selectedDate);
      });
    }
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
      child: TextField(
        controller: _dateController,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(roundness)),
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    108, 165, 165, 165), // Set your desired border color here
                width: 1.0, // Set the width of the border
              ),
            ),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(roundness)),
            label: Text(
              'SELECT DATE',
              style: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
            prefixIcon: const Icon(Icons.calendar_today),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary))),
        readOnly: true,
        onTap: _selectDate,
      ),
    );
  }
}
