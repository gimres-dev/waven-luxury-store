/// Custom class to handle general Firebase exceptions.
class TFirebaseException implements Exception {
  /// The error code of the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';
      case 'unavailable':
        return 'The Firebase service is currently unavailable. Please try again later.';
      case 'deadline-exceeded':
        return 'The deadline for the Firebase operation has been exceeded. Please try again.';
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'not-found':
        return 'The requested resource was not found.';
      case 'already-exists':
        return 'The resource you are trying to create already exists.';
      case 'cancelled':
        return 'The Firebase operation was cancelled.';
      case 'data-loss':
        return 'Unrecoverable data loss or corruption occurred.';
      case 'unauthenticated':
        return 'The user is not authenticated. Please log in and try again.';
      case 'internal':
        return 'An internal Firebase error occurred. Please try again later.';
      case 'not-implemented':
        return 'The Firebase operation is not implemented or supported.';
      case 'out-of-range':
        return 'The Firebase operation was out of range.';
      default:
        return 'An unexpected Firebase error occurred. Please try again.';
    }
  }
}