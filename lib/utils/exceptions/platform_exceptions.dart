/// Exception class for handling various platform-related errors.
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the platform method.';
      case 'unavailable':
        return 'The platform service is currently unavailable. Please try again later.';
      case 'permission-denied':
        return 'Permission denied. Please grant the necessary permissions.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'web-context-already-presented':
        return 'A web context is already being presented.';
      case 'web-context-cancelled':
        return 'The web context was cancelled by the user.';
      case 'web-invalid-origin':
        return 'The web origin is invalid. Please try again.';
      case 'web-resource-not-found':
        return 'The web resource could not be found.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'already-connected':
        return 'The device is already connected.';
      case 'connection-failed':
        return 'Connection to the platform failed. Please try again.';
      case 'no-such-file':
        return 'The requested file does not exist.';
      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}