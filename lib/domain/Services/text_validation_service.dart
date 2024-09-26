import '../../DATA/models/app_enums.dart';

/// `TextFieldValidationService` provides utility methods for validating various types of text inputs.
/// The class includes methods for validating integers, doubles, and strings, and can be extended to support
/// other types of validation (e.g., email, phone number) as needed.
class TextFieldValidationService {
  /// Returns a validation function based on the provided [ValidatorType].
  /// This function is used to validate input fields in forms.
  ///
  /// - [type]: The type of validation to apply (e.g., integer, double, string).
  /// - [allowEmpty]: Whether the field can be left empty.
  /// - [etalonText]: Optional comparison string for certain validation types (e.g., `sameAs`).
  /// - [minLength]: Minimum length of the input string (default is 3).
  ///
  /// Returns a validation function or `null` if no validation function is available for the given type.
  static String? Function(String?)? getValidatorFunction(
      ValidatorType type, bool allowEmpty,
      [String etalonText = '', int minLength = 3]) {
    switch (type) {
      case ValidatorType.integer:
        return (value) => validateInteger(value, minLength);
      case ValidatorType.double:
        return (value) => validateDouble(value, minLength);
      case ValidatorType.string:
        return (value) => validateString(value, allowEmpty, minLength);
      // Uncomment the following cases when adding more validation types
      // case ValidatorType.phoneNumber:
      //   return (value) => validatePhoneNumber(value, minLength);
      // case ValidatorType.email:
      //   return (value) => validateEmail(value, minLength);
      // case ValidatorType.name:
      //   return (value) => validateName(value, minLength);
      // case ValidatorType.sameAs:
      //   return (value) => validateSameAs(value, etalonText, minLength);
      default:
        return null;
    }
  }

  /// Validates integer input.
  ///
  /// - [value]: The input string to validate.
  /// - [minLength]: Minimum length of the input string.
  ///
  /// Returns an error message if the input is not a valid integer or does not meet the length requirement, or `null` if the input is valid.
  static String? validateInteger(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < minLength) {
      return 'Insufficient number of characters';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid integer';
    }
    return null;
  }

  /// Validates double (decimal) input.
  ///
  /// - [value]: The input string to validate.
  /// - [minLength]: Minimum length of the input string.
  ///
  /// Returns an error message if the input is not a valid double or does not meet the length requirement, or `null` if the input is valid.
  static String? validateDouble(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < minLength) {
      return 'Insufficient number of characters';
    }
    if (double.tryParse(value) == null || value.startsWith('-')) {
      return 'Please enter a positive number';
    }
    return null;
  }

  /// Validates string input.
  ///
  /// - [value]: The input string to validate.
  /// - [allowEmpty]: Whether the input can be empty.
  /// - [minLength]: Minimum length of the input string.
  ///
  /// Returns an error message if the input is not valid or does not meet the length requirement, or `null` if the input is valid.
  static String? validateString(String? value, bool allowEmpty, int minLength) {
    if (value == null || value.isEmpty) {
      return allowEmpty ? null : 'This field cannot be empty';
    }
    if (value.length < minLength) {
      return 'Insufficient number of characters';
    }
    return null;
  }

  // Uncomment these methods to add validation for other input types

  // /// Validates phone number input.
  // static String? validatePhoneNumber(String? value, int minLength) {
  //   if (value == null || value.isEmpty) {
  //     return 'This field cannot be empty';
  //   }
  //   if (value.length < minLength) {
  //     return 'Insufficient number of characters';
  //   }
  //   final regExp = RegExp(r'^\+380[0-9]{9}$');
  //   if (!regExp.hasMatch('+380$value')) {
  //     return 'Invalid phone number!';
  //   }
  //   return null;
  // }

  // /// Validates email input.
  // static String? validateEmail(String? value, int minLength) {
  //   if (value == null || value.isEmpty) {
  //     return 'This field cannot be empty';
  //   }
  //   if (value.length < minLength) {
  //     return 'Insufficient number of characters';
  //   }
  //   final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   if (!regExp.hasMatch(value)) {
  //     return 'Invalid email format!';
  //   }
  //   return null;
  // }

  // /// Validates name input.
  // static String? validateName(String? value, int minLength) {
  //   if (value == null || value.isEmpty) {
  //     return 'This field cannot be empty';
  //   }
  //   if (value.length < minLength) {
  //     return 'Insufficient number of characters';
  //   }
  //   final regExp = RegExp(r'^[a-zA-Z\s-]+$');
  //   if (!regExp.hasMatch(value)) {
  //     return 'Name can only contain letters, spaces, and hyphens!';
  //   }
  //   return null;
  // }

  // /// Validates if the input matches an expected value.
  // static String? validateSameAs(
  //     String? value, String etalonText, int minLength) {
  //   if (value == null || value.isEmpty) {
  //     return 'This field cannot be empty';
  //   }
  //   if (value.length < minLength) {
  //     return 'Insufficient number of characters';
  //   }
  //   if (value != etalonText) {
  //     return 'Text does not match the reference';
  //   }
  //   return null;
  // }
}
