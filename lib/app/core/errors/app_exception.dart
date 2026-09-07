/// App-level exception carrying a user-facing message.
///
/// Throw this (instead of a bare [Exception]) whenever the error message
/// should be shown to the user as-is, e.g. from validators or repositories.
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}
