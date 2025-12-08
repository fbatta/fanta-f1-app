class UserAlreadyExistsException implements Exception {
  final String message;

  const UserAlreadyExistsException(this.message);

  @override
  String toString() => 'UserAlreadyExistsException: $message';
}