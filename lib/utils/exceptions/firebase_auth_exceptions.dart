/// Custom class for handling various Firebase authentication-related exceptions.
class TFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The provided credentials do not correspond to the previously signed-in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for help.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-ios-bundle-id':
        return 'The iOS Bundle ID is missing. Provide a valid Bundle ID.';
      case 'missing-android-package-name':
        return 'The Android Package Name is missing. Provide a valid Package Name.';
      case 'too-many-requests':
        return 'Too many requests. Service has been temporarily disabled.';
      case 'invalid-credential':
        return 'The credential provided is malformed or has expired.';
      case 'invalid-continue-uri':
        return 'The continue URL is invalid. Provide a valid continue URL.';
      case 'missing-continue-uri':
        return 'The continue URL is missing. Provide a valid continue URL.';
      default:
        return 'An unexpected Firebase error occurred. Please try again.';
    }
  }

  /// CRITICAL FIX: This tells Flutter to show the 'message' 
  /// instead of "Instance of 'TFirebaseAuthException'"
  @override
  String toString() => message;
}