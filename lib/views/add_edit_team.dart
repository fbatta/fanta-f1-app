import 'dart:io';

import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/provider/lobby_provider.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditTeam extends ConsumerStatefulWidget {
  final Team? team;
  const AddEditTeam({super.key, this.team});

  @override
  ConsumerState createState() => _AddEditTeamState();
}

class _AddEditTeamState extends ConsumerState<AddEditTeam> {
  final _teamNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  File? _selectedAvatar;
  Lobby? _selectedLobby;

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lobbies = ref.watch(lobbyProviderProvider);

    if (lobbies.isLoading) {
      return const Scaffold(body: SpinnerCentered());
    }

    if (widget.team != null) {
      _teamNameController.text = widget.team!.teamName;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team == null ? 'Add Team' : 'Edit Team'),
      ),
      body: Stack(
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: ValueKey('TeamName'),
                        controller: _teamNameController,
                        decoration: const InputDecoration(
                          labelText: 'Team name',
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.person),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: _teamNameValidator,
                        autofocus: true,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField(
                        validator: _lobbyFieldValidator,
                        key: ValueKey('LobbyName'),
                        decoration: InputDecoration(
                          labelText: 'Lobby name',
                          border: const OutlineInputBorder(),
                          icon: const Icon(Icons.groups),
                          enabled: !_isLoading,
                        ),
                        items: lobbies.requireValue.values
                            .map(
                              (lobby) => DropdownMenuItem(
                                value: lobby,
                                child: Text(lobby.lobbyName),
                              ),
                            )
                            .toList(),
                        onChanged: _onLobbyChanged,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        key: ValueKey('LobbyPassword'),
                        decoration: InputDecoration(
                          labelText: 'Lobby password',
                          border: const OutlineInputBorder(),
                          icon: const Icon(Icons.groups),
                        ),
                        validator: _lobbyPasswordValidator,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _selectedAvatar != null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(50.0),
                                    image: DecorationImage(
                                      image: FileImage(_selectedAvatar!),
                                    ),
                                  ),
                                )
                              : Container(),
                          Spacer(),
                          FilledButton(
                            onPressed: _onSelectAvatarButtonPressed,
                            child: const Text("Upload team logo"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isLoading
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: SpinnerCentered(),
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _onCreateTeamButtonPressed,
        label: Text('Save'),
        icon: Icon(Icons.save),
      ),
    );
  }

  void _onSelectAvatarButtonPressed() async {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      setState(() {
        _selectedAvatar = File(filePickerResult.files[0].path!);
      });
    }
  }

  String? _teamNameValidator(String? value) {
    if (value != null && value.length > 3) {
      return null;
    }
    return 'Team name must be at least 4 characters long';
  }

  void _onLobbyChanged(Lobby? value) {
    if (value != null) {
      setState(() {
        _selectedLobby = value;
      });
    }
  }

  String? _lobbyFieldValidator(Lobby? value) {
    if (value != null) {
      return null;
    }
    return 'Please select a lobby';
  }

  Future<void> _onCreateTeamButtonPressed() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }

      await ref
          .read(teamProviderProvider.notifier)
          .addTeam(
            lobbyId: _selectedLobby!.lobbyId,
            teamName: _teamNameController.text,
          );

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Team created')));
        context.pop();
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _lobbyPasswordValidator(String? value) {
    if (value == null) {
      return 'Please enter the lobby password';
    }
    if (_selectedLobby == null) {
      return 'Please select a lobby';
    }
    if (value != _selectedLobby!.lobbyPassword) {
      return 'Incorrect lobby password';
    }
    return null;
  }
}
