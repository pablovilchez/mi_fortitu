/// Validates the email, password, confirm password and login name.
///
/// This class contains methods to validate email, password, confirm password and login name.
class Validators {
  static String? validateEmail(String? email) {
    if (email == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  static String? validateConfirmPassword(String password, String? confirmPassword) {
    if (confirmPassword == null || password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateLoginName(String? loginName) {
    if (loginName == null || loginName.isEmpty) {
      return 'Login name cannot be empty';
    }
    return null;
  }
}