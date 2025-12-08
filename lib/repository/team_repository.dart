import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/team/team.dart';

class TeamRepository {
  late final FirebaseFirestore _firestore;
  late final CollectionReference _teamsCollection;

  TeamRepository(FirebaseFirestore instance) {
    _firestore = instance;
    _teamsCollection = _firestore.collection('teams');
  }

  Future<Team?> findTeamById(String teamId) async {
    final snapshot = await _teamsCollection.doc(teamId).get();
    if (snapshot.exists) {
      return Team.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> createOrUpdateTeam(Team team) async {
    final existingTeam = await findTeamById(team.teamId);
    if(existingTeam != null) {
      await _teamsCollection.doc(team.teamId).update(team.toJson());
      return;
    }

    await _teamsCollection.doc(team.teamId).set(team.toJson());
  }
}