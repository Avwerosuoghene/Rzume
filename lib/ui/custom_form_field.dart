import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField(
      {super.key,
      required this.formHint,
      required this.formLabel,
      required this.formPreficIcon,
      required this.validatorFunction,
      required this.inputValue,
      TextInputType? keyboardType,
      required this.showSuffixIcon,
      required this.onChangeEvent})
      : keyboardType = keyboardType ?? TextInputType.text;

  final String formHint;
  final String formLabel;
  final String formPreficIcon;
  final String? Function(String? value) validatorFunction;
  final TextInputType? keyboardType;
  final void Function(String? value) inputValue;
  final bool showSuffixIcon;
  final void Function(String value) onChangeEvent;

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
            hintText: widget.formHint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            label: Text(
              widget.formLabel,
              style: const TextStyle(
                  color: Color.fromARGB(255, 98, 98, 98),
                  fontSize: 12,
                  fontWeight: FontWeight.w200),
            ),
            prefixIcon: SizedBox(
              // width: 200,
              child: Image.asset(
                widget.formPreficIcon,
              ),
            ),
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
        validator: widget.validatorFunction,
        // onSaved: widget.inputValue,
        obscureText: hideText);
  }
}
