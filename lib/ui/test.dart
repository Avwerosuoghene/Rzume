// import 'package:flutter/material.dart';

// import '../model/enums.dart';

// class CustomFormField extends StatefulWidget {
//   CustomFormField({
//     super.key,
//     required this.formHint,
//     required this.formLabel,
//     required this.formPrefixIcon,
//     required this.validatorFunction,
//     required this.inputValue,
//     TextInputType? keyboardType,
//     required this.showSuffixIcon,
//     required this.onChangeEvent,
//     this.roundnessDegree = Roundness.partial,
//   }) : keyboardType = keyboardType ?? TextInputType.text;

//   final String formHint;
//   final String formLabel;
//   final String formPrefixIcon;
//   final String? Function(String? value) validatorFunction;
//   final TextInputType? keyboardType;
//   final void Function(String? value) inputValue;
//   final bool showSuffixIcon;
//   final void Function(String value) onChangeEvent;
//   final Roundness? roundnessDegree;

//   @override
//   State<CustomFormField> createState() {
//     return _CustomFormFieldState();
//   }
// }

// class _CustomFormFieldState extends State<CustomFormField> {
//   late bool hideText;

//   @override
//   void initState() {
//     super.initState();
//     hideText = widget.showSuffixIcon;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final roundness = widget.roundnessDegree!.value;
//     return TextFormField(
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: Theme.of(context)
//             .textTheme
//             .bodyMedium!
//             .copyWith(color: Colors.black),
//         keyboardType: widget.keyboardType,
//         textCapitalization: TextCapitalization.none,
//         autocorrect: false,
//         onChanged: widget.onChangeEvent,
//         decoration: InputDecoration(
//             // contentPadding: EdgeInsets.symmetric(vertical: 10),
//             hintText: widget.formHint,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(roundness)),
//             label: Text(
//               widget.formLabel,
//               style: const TextStyle(
//                   color: Color.fromARGB(255, 98, 98, 98),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w200),
//             ),
//             // prefixIconConstraints:
//             //     const BoxConstraints(minHeight: 0, minWidth: 0),
//             prefixIcon: Container(
//               // padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               height: 30,
//               child: Image.asset(
//                 widget.formPrefixIcon,
//                 height: 20,
//               ),
//             ),
//             suffixIcon: widget.showSuffixIcon
//                 ? IconButton(
//                     icon: Icon(
//                       !hideText ? Icons.visibility : Icons.visibility_off,
//                       color: const Color.fromARGB(255, 130, 130, 130),
//                     ),
//                     tooltip: 'Show',
//                     onPressed: () {
//                       // print(showPass);
//                       setState(() {
//                         hideText = !hideText;
//                       });
//                     },
//                   )
//                 : null),
//         validator: widget.validatorFunction,
//         // onSaved: widget.inputValue,
//         obscureText: hideText);
//   }
// }
