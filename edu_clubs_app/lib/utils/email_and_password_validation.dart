class EmailAndPasswordValidation {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@eastdelta\.edu\.bd$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
