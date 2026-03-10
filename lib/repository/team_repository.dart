import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/exception/invalid_request_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class TeamRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _teamsCollection;
  late final FirebaseStorage _storage;
  late final Reference _storageRef;

  TeamRepository() {
    _firestore = _getIt();
    _storage = _getIt();
    _teamsCollection = _firestore.collection('teams');
    _storageRef = _storage.ref();
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

  Future<String> uploadAvatar(String teamId, String userId, XFile file) async {
    final extension = file.name.split('.').last;
    final imageRef = _storageRef.child(
      '/team_avatars/$userId/$teamId/avatar.$extension',
    );

    final mimeType = lookupMimeType(file.path);
    final contents = await file.readAsBytes();
    final snapshot = await imageRef.putData(
      contents,
      SettableMetadata(contentType: mimeType),
    );
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
