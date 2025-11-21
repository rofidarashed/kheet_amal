import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppValidators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display name must be between 3 and 20 characters';
    }

    return null;
  }

  static String? fieldValidator(String? desc) {
    if (desc == null || desc.isEmpty) {
      return 'required'.tr();
    }
    if (desc.length < 20) {
      return 'The Text is too short';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    ).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phoneValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone';
    }
    if (!RegExp(r'^01[0-2|5]\d{8}$').hasMatch(value)) {
      return "Phone number must start with 010, 011, 012, or 015 \nand be 11 digits long";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? nationalIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a national ID';
    }
    if (value.length < 14 || value.length > 14) {
      return 'National ID must be 14 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? genderValidator({String? value}) {
    if (value == null || value.isEmpty) {
      return 'Please enter gender';
    }
    if ((value != "female" && value != "Female") &&
        (value != "male" && value != "Male")) {
      return 'Invalid gender, Please Enter female or male';
    }
    return null;
  }

  static String? imageValidator(String? image) {
    if (image == null || image.isEmpty) {
      return 'Image cannot be empty';
    }
    return null;
  }

  static String? tokenValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Token cannot be empty';
    }
    return null;
  }

  static String? dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }
    try {
      // Attempt to parse the date. This will handle various formats.
      // The output from the date picker might not be in yyyy-MM-dd format.
      DateFormat.yMd().parse(value);
    } catch (e) {
      // If parsing fails, it's not a valid date.
      return 'Please enter a valid date';
    }
    return null;
  }

  static String? checkboxValidator(bool? value) {
    if (value == null || value == false) {
      return 'check'.tr();
    }
    return null;
  }
}
