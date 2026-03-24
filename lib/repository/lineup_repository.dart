import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/lineup/lineup.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:get_it/get_it.dart';

class LineupRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _lineupsCollection;
  late final TimeUtils _timeUtils;

  LineupRepository() {
    _firestore = _getIt();
    _timeUtils = _getIt();
    _lineupsCollection = _firestore.collection('lineups');
  }

  Future<Lineup?> findLineupById(String teamId, String raceId) async {
    final snapshot = await _lineupsCollection
        .where('teamId', isEqualTo: teamId)
        .where('raceId', isEqualTo: raceId)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return Lineup.fromJson(
        snapshot.docs.first.data() as Map<String, dynamic>,
      );
    }
    return null;
  }

  Future<Lineup?> findLatestLineupByTeamId(String teamId, int year) async {
    final startDate = DateTime(year, 1, 1).toUtc();
    final snapshot = await _lineupsCollection
        .where('teamId', isEqualTo: teamId)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: startDate.millisecondsSinceEpoch,
        )
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    return Lineup.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }

  Future<List<Lineup>> getLineupsByTeamId(String teamId) async {
    final year = (await _timeUtils.tryGetNetworkTime()).toUtc().year;
    final startDate = DateTime(year, 1, 1).toUtc();
    final endDate = DateTime(year, 12, 31).toUtc();

    final snapshot = await _lineupsCollection
        .where('teamId', isEqualTo: teamId)
        .where('createdAt', isGreaterThanOrEqualTo: startDate)
        .where('createdAt', isLessThanOrEqualTo: endDate)
        .orderBy('createdAt')
        .get();
    return snapshot.docs
        .map((doc) => Lineup.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Lineup>> getLineupsByTeamIdsAndRaceId(
    List<String> teamIds,
    String raceId,
  ) async {
    final snapshot = await _lineupsCollection
        .where('teamId', whereIn: teamIds)
        .where('raceId', isEqualTo: raceId)
        .orderBy('score', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Lineup.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Lineup?> findLineup(Lineup lineup) async {
    return findLineupById(lineup.teamId, lineup.raceId);
  }

  Future<void> createOrUpdateLineup(Lineup lineup) async {
    await _lineupsCollection.doc(lineup.lineupId).set(lineup.toJson());
  }
}
