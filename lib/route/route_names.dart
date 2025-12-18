enum RouteNames {
  signIn('/'),
  forgotPassword('/forgotPassword'),
  signUp('/signUp'),
  home('/home');

  final String path;

  const RouteNames(this.path);

  @override
  String toString() => name;
}