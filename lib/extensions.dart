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

  // String get formatPhilippineNumber {
  //   String formatted = replaceAll(RegExp(r'\D'), '');
  //   if (formatted.length == 10 && formatted.startsWith('9')) {
  //     return '+63$formatted';
  //   } else if (formatted.length == 12 && formatted.startsWith('63')) {
  //     return '+$formatted';
  //   }
  //   return this;
  // }
}
