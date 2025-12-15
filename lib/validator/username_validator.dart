String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }
  if (value.contains(' ')) {
    return 'Username cannot contain spaces';
  }
  if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}