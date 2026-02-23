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
  FutureOr<Map<String, Lobby>> build() async {
    _lobbyRepository = _getIt();
    final lobbies = await _lobbyRepository.getLobbies();

    return {for (final lobby in lobbies) lobby.lobbyId: lobby};
  }

  Future<void> createLobby(Lobby lobby) async {
    return await _lobbyRepository.createLobby(lobby);
  }

  Future<void> updateLobbyNameOrPassword({
    required String lobbyId,
    String? name,
    String? password,
  }) async {
    final currentState = state.requireValue;
    final lobby = currentState[lobbyId];

    throwIf(lobby == null, Exception("No lobby found with id $lobbyId"));

    final newLobbyDetails = lobby!.copyWith(
      lobbyName: name ?? lobby.lobbyName,
      lobbyPassword: password ?? lobby.lobbyPassword,
    );

    await _lobbyRepository.updateLobby(newLobbyDetails);

    currentState[lobbyId] = newLobbyDetails;
    AsyncValue.data(currentState);
  }
}
