import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:fanta_f1/repository/lobby_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lobby_provider.g.dart';

@riverpod
class LobbyProvider extends _$LobbyProvider {
  final _getIt = GetIt.instance;
  late final LobbyRepository _lobbyRepository;

  @override
  FutureOr<List<Lobby>> build() async {
    _lobbyRepository = _getIt();
    return await _lobbyRepository.getLobbies();
  }
}
