import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:fanta_f1/provider/lobby_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/v4.dart';

class AddEditLobby extends ConsumerStatefulWidget {
  final Lobby? lobby;
  const AddEditLobby({super.key, this.lobby});

  @override
  ConsumerState createState() => _AddEditLobbyState();
}

class _AddEditLobbyState extends ConsumerState<AddEditLobby> {
  final _getIt = GetIt.instance;
  final _formKey = GlobalKey<FormState>();
  final _lobbyNameController = TextEditingController();
  final _lobbyPasswordController = TextEditingController();
  late final FirebaseAuth _auth;

  bool _isLoading = false;

  @override
  void initState() {
    _auth = _getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add lobby')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: ValueKey('lobbyName'),
                  controller: _lobbyNameController,
                  decoration: const InputDecoration(
                    labelText: 'Lobby name',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.groups),
                  ),
                  validator: _lobbyNameValidator,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  key: ValueKey('lobbyPassword'),
                  controller: _lobbyPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Lobby password',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.password),
                  ),
                  validator: _lobbyPasswordValidator,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onCreateLobbyButtonPressed,
        label: Text('Save'),
        icon: Icon(Icons.save),
      ),
    );
  }

  Future<void> _onCreateLobbyButtonPressed() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      final lobby = Lobby(
        lobbyId: UuidV4().toString(),
        lobbyName: _lobbyNameController.text,
        ownerId: _auth.currentUser!.uid,
        memberIds: [],
        lobbyPassword: _lobbyPasswordController.text,
        createdAt: DateTime.timestamp(),
        updatedAt: DateTime.timestamp(),
      );

      await ref.read(lobbyProviderProvider.notifier).createLobby(lobby);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lobby created')));
        context.pop();
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _lobbyNameValidator(String? value) {
    if (value != null && value.length >= 5) {
      return null;
    }
    return 'Lobby name must be at least 5 characters long';
  }

  String? _lobbyPasswordValidator(String? value) {
    if (value != null && value.length >= 6) {
      return null;
    }
    return 'Lobby password must be at least 6 characters long';
  }
}
