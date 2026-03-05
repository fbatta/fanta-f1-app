class InvalidRequestException implements Exception {
  final String message;

  const InvalidRequestException(this.message);

  @override
  String toString() => "InvalidRequestException: $message";
}
