import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFormatOnChange;
  final bool isRequired;
  final bool validateOnChange;
  final GlobalKey<FormFieldState>? fieldKey; // ✅ new optional key

  const CustomFormField({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.autoFormatOnChange = false,
    this.isRequired = true,
    this.validateOnChange = false,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: (value) {
        // ✅ Only validate this specific field
        if (validateOnChange && fieldKey != null) {
          fieldKey!.currentState?.validate();
        }

        // Auto-format for phone fields
        // if (autoFormatOnChange && keyboardType == TextInputType.phone) {
        //   final formattedValue = value.formatPhilippineNumber;
        //   controller?.text = formattedValue;
        //   controller?.selection = TextSelection.fromPosition(
        //     TextPosition(offset: formattedValue.length),
        //   );
        // }

        if (onChanged != null) onChanged!(value);
      },
      validator:
          validator ??
          (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return '$label is required';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: isRequired ? label : '$label (optional)',
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

// class PhoneNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Strip out non-digit characters
//     String formatted = newValue.text.replaceAll(RegExp(r'\D'), '');

//     // If input length is greater than 10, truncate it to 10 characters
//     if (formatted.length > 11) {
//       formatted = formatted.substring(0, 11);
//     }

//     // Ensure the number starts with "09"
//     if (formatted.length > 2 && !formatted.startsWith('09')) {
//       formatted =
//           '09${formatted.substring(3)}'; // Start with '09' if not already
//     }

//     // Return the updated text and cursor position
//     return TextEditingValue(
//       text: formatted,
//       selection: TextSelection.collapsed(offset: formatted.length),
//     );
//   }
// }
