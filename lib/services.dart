import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Utility Extensions for validation and formatting
extension InputValidators on String {
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );
    return emailRegex.hasMatch(trim());
  }

  // bool get isValidPassword {
  //   final passwordRegex = RegExp(
  //     r'^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[@$!%?&])[A-Za-z\d@$!%?&]{8,}$',
  //   );
  //   return passwordRegex.hasMatch(this);
  // }

  bool get isValidPassword {
    final passwordRegex = RegExp(r'^[a-zA-Z0-9@$!%?&]{8,}$');
    return passwordRegex.hasMatch(this);
  }

  bool get isValidPhilippineNumber {
    final phRegex = RegExp(r'^(\+63|0)9\d{9}$');
    return phRegex.hasMatch(trim());
  }

  String get formatPhilippineNumber {
    String formatted = replaceAll(RegExp(r'\D'), '');
    if (formatted.length == 10 && formatted.startsWith('9')) {
      return '+63$formatted';
    } else if (formatted.length == 12 && formatted.startsWith('63')) {
      return '+$formatted';
    }
    return this;
  }
}

class CustomFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFormatOnChange;
  final bool isPasswordField;
  final bool isRequired; // New flag for required/optional field
  final GlobalKey<FormState> formKey; // Pass the form key to trigger validation

  const CustomFormField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.autoFormatOnChange = false,
    this.isPasswordField = false,
    this.isRequired = true, // Default is required
    required this.formKey, // Add formKey parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField ? true : obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: (value) {
        // Trigger validation on text change
        formKey.currentState?.validate();

        if (autoFormatOnChange && keyboardType == TextInputType.phone) {
          // Automatically format phone number if it's a phone field
          final formattedValue = value.formatPhilippineNumber;
          controller?.text = formattedValue;
          controller?.selection = TextSelection.fromPosition(
            TextPosition(offset: formattedValue.length),
          );
        }
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
        labelText: isRequired ? label : '$label${' (optional)'}',
        hintText: isRequired
            ? null
            : null, // Show 'Optional' hint if the field is not required
        border: OutlineInputBorder(),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Strip out non-digit characters
    String formatted = newValue.text.replaceAll(RegExp(r'\D'), '');

    // If input length is greater than 10, truncate it to 10 characters
    if (formatted.length > 11) {
      formatted = formatted.substring(0, 11);
    }

    // // Ensure the number starts with "09"
    // if (formatted.length > 2 && !formatted.startsWith('09')) {
    //   formatted =
    //       '09' + formatted.substring(2); // Start with '09' if not already
    // }

    // Return the updated text and cursor position
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
