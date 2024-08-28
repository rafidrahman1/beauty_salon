class FormValidators {
  static String? validateRequired(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^(\+61|0)[2-478]\d{8}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid Australian phone number';
    }
    return null;
  }
}
