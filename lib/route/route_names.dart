enum RouteNames {
  signIn('/'),
  forgotPassword('/forgotPassword'),
  signUp('/signUp'),
  home('/home'),
  addTeam('/team/add'),
  editTeam('/team/edit');

  final String path;

  const RouteNames(this.path);

  @override
  String toString() => name;
}
