import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/exception/invalid_request_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

class TeamRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _teamsCollection;
  late final FirebaseStorage _storage;

  TeamRepository() {
    _firestore = _getIt();
    _storage = _getIt();
    _teamsCollection = _firestore.collection('teams');
  }

  Future<Team?> findTeamById(String teamId) async {
    final snapshot = await _teamsCollection.doc(teamId).get();
    if (snapshot.exists) {
      return Team.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<Team>> getTeamsByOwnerId(String ownerId) async {
    final snapshot = await _teamsCollection
        .where('ownerId', isEqualTo: ownerId)
        .get();
    return snapshot.docs
        .map((doc) => Team.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Team>> getTeamsInLobby(String lobbyId) async {
    final snapshot = await _teamsCollection
        .where('lobbyId', isEqualTo: lobbyId)
        .get();
    return snapshot.docs
        .map((doc) => Team.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<bool> hasTeamInLobby(String lobbyId, String ownerId) async {
    final snapshot = await _teamsCollection
        .where('lobbyId', isEqualTo: lobbyId)
        .where('ownerId', isEqualTo: ownerId)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> updateTeam(Team team) async {
    await _teamsCollection.doc(team.teamId).update(team.toJson());
  }

  Future<void> createTeam(Team team) async {
    final existingTeam = await findTeamById(team.teamId);
    if (existingTeam != null) {
      throw InvalidRequestException('Team ${team.teamName} already exists.');
    }
    await _teamsCollection.doc(team.teamId).set(team.toJson());
  }

  Future<String> uploadAvatar(String teamId, String userId, File file) async {
    final ref = _storage.ref('/team_avatars/$userId/$teamId');
    final snapshot = await ref.putFile(file);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
