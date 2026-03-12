// validators.dart
class Validators {
  // ──────────────── General ────────────────

  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    if (value.trim().length < min) {
      return message ?? 'Must be at least $min characters';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    if (value.trim().length > max) {
      return message ?? 'Must be no more than $max characters';
    }
    return null;
  }

  // ──────────────── Numbers ────────────────

  static String? number(String? value, {String? message}) {
    if (value == null || value.isEmpty) return null;

    final regex = RegExp(r'^01[0125][0-9]{8}$');

    if (!regex.hasMatch(value)) {
      return message ?? 'Please enter a valid Egyptian phone number';
    }
    return null;
  }

  static String? positiveNumber(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;

    final num = double.tryParse(value.trim());
    if (num == null) return 'Please enter a valid number';
    if (num <= 0) return message ?? 'Must be greater than zero';

    return null;
  }

  // ──────────────── Email ────────────────

  static String? email(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return message ?? 'Please enter a valid email address';
    }
    return null;
  }

  // ──────────────── Password ────────────────

  static String? password(String? value, {String? message}) {
    if (value == null || value.isEmpty) return null;

    final regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
    );

    if (!regex.hasMatch(value)) {
      return message ??
          'Password must be at least 8 characters, include upper & lower case letters, a number, and a special character';
    }

    return null;
  }

  static String? strongPassword(String? value, {String? message}) {
    if (value == null || value.isEmpty) return null;

    if (value.length < 8) {
      return message ?? 'Password must be at least 8 characters';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Must contain at least one number';
    }

    return null;
  }

  // ──────────────── Confirm Password ────────────────

  static String? confirmPassword(
    String? value,
    String originalPassword, {
    String? message,
  }) {
    if (value != originalPassword) {
      return message ?? 'Passwords do not match';
    }
    return null;
  }

  // ──────────────── Compose multiple validators ────────────────

  static String? compose(
    List<String? Function(String?)> validators,
    String? value,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }

  // Example usage with compose:
  // validator: Validators.compose([
  //   (v) => Validators.required(v),
  //   (v) => Validators.minLength(v, 3),
  //   (v) => Validators.email(v),
  // ]),
}
