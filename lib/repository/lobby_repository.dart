import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:get_it/get_it.dart';

class LobbyRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _lobbies;

  LobbyRepository() {
    _firestore = _getIt();
    _lobbies = _firestore.collection('lobbies');
  }

  Future<List<Lobby>> getLobbies() async {
    final snapshot = await _lobbies.get();
    return snapshot.docs
        .map((doc) => Lobby.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> createLobby(Lobby lobby) async {
    await _lobbies.doc(lobby.lobbyId).set(lobby.toJson());
  }

  Future<void> updateLobby(Lobby lobby) async {
    await _lobbies.doc(lobby.lobbyId).update(lobby.toJson());
  }
}
