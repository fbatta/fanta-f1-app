enum RouteNames {
  signIn('/'),
  forgotPassword('/forgotPassword'),
  signUp('/signUp'),
  home('/home'),
  addTeam('/team/add'),
  editTeam('/team/:teamId/edit'),
  team('/team/:teamId'),
  addLobby('/lobby/add'),
  editLobby('/lobby/edit'),
  calendar('/calendar'),
  lineup('/lineup/:teamId/:raceId'),
  account('/account'),
  notFound('/notFound');

  final String path;

  const RouteNames(this.path);

  @override
  String toString() => name;

  static RouteNames fromPath(String path) {
    for (final route in RouteNames.values) {
      if (route.path == path) {
        return route;
      }
    }
    return RouteNames.notFound;
  }
}
