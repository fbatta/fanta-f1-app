import 'package:fanta_f1/component/error_snack_bar.dart';
import 'package:fanta_f1/component/success_snack_bar.dart';
import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:fanta_f1/provider/lobby_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditLobby extends ConsumerStatefulWidget {
  final Lobby? lobby;
  const AddEditLobby({super.key, this.lobby});

  @override
  ConsumerState createState() => _AddEditLobbyState();
}

class _AddEditLobbyState extends ConsumerState<AddEditLobby> {
  final _formKey = GlobalKey<FormState>();
  final _lobbyNameController = TextEditingController();
  final _lobbyPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add lobby')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                SizedBox(height: 16.0),
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

      await ref
          .read(lobbyProviderProvider.notifier)
          .createLobby(
            lobbyName: _lobbyNameController.text,
            lobbyPassword: _lobbyPasswordController.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(successSnackBar(context: context, text: 'Lobby created'));
      context.pop();
    } catch (e) {
      // TODO: record error
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(
          context: context,
          text: 'Something went wrong, please try again later',
        ),
      );
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
