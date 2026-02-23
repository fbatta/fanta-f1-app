import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/exception/team_not_found_exception.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/v4.dart';

part 'team_provider.g.dart';

@riverpod
class TeamProvider extends _$TeamProvider {
  final GetIt _getIt = GetIt.instance;
  late final TeamRepository _teamRepository;
  late final FirebaseAuth _firebaseAuth;

  @override
  FutureOr<Map<String, Team>> build() async {
    _teamRepository = _getIt();
    _firebaseAuth = _getIt();

    final teams = await _teamRepository.getTeamsByOwnerId(
      _firebaseAuth.currentUser!.uid,
    );

    return {for (var team in teams) team.teamId: team};
  }

  Future<void> addTeam({
    required String teamName,
    required String lobbyId,
    String? teamAvatarUrl,
  }) async {
    final teamId = UuidV4().generate();

    final team = Team(
      teamId: teamId,
      teamName: teamName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerId: _firebaseAuth.currentUser!.uid,
      lobbyId: lobbyId,
      teamAvatarUrl: teamAvatarUrl,
    );

    await _teamRepository.createOrUpdateTeam(team);

    final currentState = state.value ?? <String, Team>{};
    currentState.addAll({teamId: team});
    state = AsyncValue.data(currentState);
  }

  Future<void> updateTeamNameOrAvatar({
    required String teamId,
    String? newTeamName,
    String? teamAvatarUrl,
  }) async {
    final currentState = state.value ?? <String, Team>{};

    if (!currentState.containsKey(teamId)) {
      throw TeamNotFoundException("No team found with id: $teamId");
    }

    final team = currentState[teamId]!.copyWith(
      teamName: newTeamName ?? currentState[teamId]!.teamName,
      teamAvatarUrl: teamAvatarUrl ?? currentState[teamId]!.teamAvatarUrl,
      updatedAt: DateTime.now(),
    );

    await _teamRepository.createOrUpdateTeam(team);

    currentState[teamId] = team;
    state = AsyncValue.data(currentState);
  }
}
