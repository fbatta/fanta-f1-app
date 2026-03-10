import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/exception/invalid_request_exception.dart';
import 'package:fanta_f1/exception/team_not_found_exception.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/v5.dart';

part 'team_provider.g.dart';

@riverpod
class TeamProvider extends _$TeamProvider {
  final GetIt _getIt = GetIt.instance;
  late TeamRepository _teamRepository;
  late FirebaseAuth _firebaseAuth;
  late TimeUtils _timeUtils;

  @override
  FutureOr<Map<String, Team>> build() async {
    _teamRepository = _getIt();
    _firebaseAuth = _getIt();
    _timeUtils = _getIt();

    final teams = await _teamRepository.getTeamsByOwnerId(
      _firebaseAuth.currentUser!.uid,
    );

    return {for (var team in teams) team.teamId: team};
  }

  Future<String> addTeam({
    required String teamName,
    required String lobbyId,
    String? teamAvatarUrl,
  }) async {
    final teamId = UuidV5().generate(lobbyId, teamName);
    final currentYear = (await _timeUtils.tryGetNetworkTime()).year;

    final team = Team(
      teamId: teamId,
      teamName: teamName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerId: _firebaseAuth.currentUser!.uid,
      lobbyId: lobbyId,
      teamAvatarUrl: teamAvatarUrl,
      points: {currentYear: 0.0},
    );

    final hasTeamInLobby = await _teamRepository.hasTeamInLobby(
      lobbyId,
      _firebaseAuth.currentUser!.uid,
    );
    if (hasTeamInLobby) {
      throw InvalidRequestException('You already have a team in this lobby');
    }

    await _teamRepository.createTeam(team);

    final currentState = state.value ?? <String, Team>{};
    currentState.addAll({teamId: team});
    state = AsyncValue.data(currentState);
    return teamId;
  }

  Future<String> uploadAvatar(XFile file, String teamId) async {
    final downloadUrl = await _teamRepository.uploadAvatar(
      teamId,
      _firebaseAuth.currentUser!.uid,
      file,
    );
    return downloadUrl;
  }

  Future<void> updateTeamNameOrAvatar({
    required String teamId,
    String? newTeamName,
    XFile? teamAvatar,
  }) async {
    final currentState = state.value ?? <String, Team>{};

    if (!currentState.containsKey(teamId)) {
      throw TeamNotFoundException("No team found with id: $teamId");
    }
    String? avatarUrl;
    if (teamAvatar != null) {
      avatarUrl = await uploadAvatar(teamAvatar, teamId);
    }

    final team = currentState[teamId]!.copyWith(
      teamName: newTeamName ?? currentState[teamId]!.teamName,
      teamAvatarUrl: avatarUrl ?? currentState[teamId]!.teamAvatarUrl,
      updatedAt: DateTime.now(),
    );

    await _teamRepository.updateTeam(team);

    currentState[teamId] = team;
    state = AsyncValue.data(currentState);
  }

  Future<List<Team>> getStandingsForLobby(String lobbyId) async {
    final year = (await _timeUtils.tryGetNetworkTime()).year;
    final standings = (await _teamRepository.getTeamsInLobby(lobbyId));
    standings.sort((a, b) => b.points[year]!.compareTo(a.points[year]!));
    return standings;
  }
}
