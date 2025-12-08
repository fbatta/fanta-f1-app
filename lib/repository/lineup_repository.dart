import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/lineup/lineup.dart';

class LineupRepository {
  late final FirebaseFirestore _firestore;
  late final CollectionReference _lineupsCollection;

  LineupRepository(FirebaseFirestore instance) {
    _firestore = instance;
    _lineupsCollection = _firestore.collection('lineups');
  }

  Future<Lineup?> findLineupById(String teamId, String raceId) async {
    final lineupId = '${teamId}_$raceId';
    final snapshot = await _lineupsCollection.doc(lineupId).get();
    if(snapshot.exists) {
      return Lineup.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<Lineup?> findLineup(Lineup lineup) async {
    return findLineupById(lineup.teamId, lineup.raceId);
  }

  Future<void> createOrUpdateLineup(Lineup lineup) async {
    final existingLineup = await findLineup(lineup);
    if(existingLineup != null) {
      await _lineupsCollection.doc(existingLineup.lineupId).update(lineup.toJson());
    } else {
      await _lineupsCollection.doc(lineup.lineupId).set(lineup.toJson());
    }
  }
}