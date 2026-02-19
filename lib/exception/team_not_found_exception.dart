class TeamNotFoundException implements Exception {
  final String message;

  const TeamNotFoundException(this.message);

  @override
  String toString() => 'TeamNotFoundException: $message';
}
