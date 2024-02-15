import 'package:flutter/material.dart';

import '../model/enums.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {super.key,
      required this.formHint,
      required this.formLabel,
      required this.formPrefixIcon,
      required this.validatorFunction,
      required this.inputValue,
      TextInputType? keyboardType,
      required this.showSuffixIcon,
      required this.onChangeEvent,
      this.roundnessDegree = Roundness.partial,
      this.showValidator = true})
      : keyboardType = keyboardType ?? TextInputType.text;

  final String formHint;
  final String formLabel;
  final String formPrefixIcon;
  final String? Function(String? value) validatorFunction;
  final TextInputType? keyboardType;
  final void Function(String? value) inputValue;
  final bool showSuffixIcon;
  final void Function(String value) onChangeEvent;
  final Roundness? roundnessDegree;
  final bool? showValidator;

  @override
  State<CustomFormField> createState() {
    return _CustomFormFieldState();
  }
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool hideText;

  @override
  void initState() {
    super.initState();
    hideText = widget.showSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    final roundness = widget.roundnessDegree!.value;
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        keyboardType: widget.keyboardType,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        onChanged: widget.onChangeEvent,
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
            hintText: widget.formHint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(roundness)),
            label: Text(
              widget.formLabel,
              style: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
            prefixIconConstraints:
                const BoxConstraints(minHeight: 0, minWidth: 0),
            prefixIcon: widget.formPrefixIcon != ''
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: 30,
                    child: Image.asset(
                      widget.formPrefixIcon,
                      height: 10,
                    ),
                  )
                : null,
            suffixIcon: widget.showSuffixIcon
                ? IconButton(
                    icon: Icon(
                      !hideText ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 130, 130, 130),
                    ),
                    tooltip: 'Show',
                    onPressed: () {
                      // print(showPass);
                      setState(() {
                        hideText = !hideText;
                      });
                    },
                  )
                : null),
       
       
        validator:
            widget.showValidator == true ? widget.validatorFunction : null,
        onSaved: widget.inputValue,
        obscureText: hideText);
  }
}
