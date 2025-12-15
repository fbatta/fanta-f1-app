String? passwordValidator(String? password) {
  if(password == null || password.length < 8) {
    return 'The password needs to be at least 8 characters.';
  }
  if(!password.contains(RegExp(r'\d+'))) {
    return 'The password needs to contain at least one number';
  }
  return null;
}