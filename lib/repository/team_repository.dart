import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:get_it/get_it.dart';

class TeamRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _teamsCollection;

  TeamRepository() {
    _firestore = _getIt();
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

  Future<void> createOrUpdateTeam(Team team) async {
    final existingTeam = await findTeamById(team.teamId);
    if (existingTeam != null) {
      await _teamsCollection.doc(team.teamId).update(team.toJson());
      return;
    }

    await _teamsCollection.doc(team.teamId).set(team.toJson());
  }
}
