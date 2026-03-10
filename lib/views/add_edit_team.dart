import 'dart:io';

import 'package:fanta_f1/component/error_snack_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/component/success_snack_bar.dart';
import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/exception/invalid_request_exception.dart';
import 'package:fanta_f1/provider/lobby_provider.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';

class AddEditTeam extends ConsumerStatefulWidget {
  final Team? team;
  const AddEditTeam({super.key, this.team});

  @override
  ConsumerState createState() => _AddEditTeamState();
}

class _AddEditTeamState extends ConsumerState<AddEditTeam> {
  final _logger = Logger((_AddEditTeamState).toString());
  final _teamNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isDirty = false;
  XFile? _selectedAvatar;
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

    if (widget.team != null && _isDirty == false) {
      _teamNameController.text = widget.team!.teamName;
      _selectedAvatar = widget.team!.teamAvatarUrl != null
          ? XFile(widget.team!.teamAvatarUrl!)
          : null;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team == null ? 'Add Team' : 'Edit Team'),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _selectedAvatar != null
                        ? (_isDirty
                              ? FileImage(File(_selectedAvatar!.path))
                              : NetworkImage(_selectedAvatar!.path))
                        : AssetImage('assets/images/idgaf1_default_avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Form(
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
                      onChanged: _onFieldChanged,
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
                        enabled: !_isLoading && widget.team == null,
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
                      enabled: !_isLoading && widget.team == null,
                      onChanged: _onFieldChanged,
                    ),
                    const SizedBox(height: 16.0),
                    FilledButton(
                      onPressed: _onSelectAvatarButtonPressed,
                      child: const Text("Upload team logo"),
                    ),
                  ],
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
      floatingActionButton: widget.team == null
          ? FloatingActionButton.extended(
              onPressed: _isLoading ? null : _onCreateTeamButtonPressed,
              label: Text('Save'),
              icon: Icon(Icons.save),
            )
          : FloatingActionButton.extended(
              onPressed: _isLoading ? null : _onUpdateTeamPressed,
              label: Text('Update'),
              icon: Icon(Icons.save),
            ),
    );
  }

  void _onSelectAvatarButtonPressed() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxHeight: 1024,
      maxWidth: 1024,
    );

    if (result != null) {
      setState(() {
        _isDirty = true;
        _selectedAvatar = result;
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

      final teamId = await ref
          .read(teamProviderProvider.notifier)
          .addTeam(
            lobbyId: _selectedLobby!.lobbyId,
            teamName: _teamNameController.text,
          );
      if (_selectedAvatar != null) {
        await ref
            .read(teamProviderProvider.notifier)
            .updateTeamNameOrAvatar(
              teamId: teamId,
              teamAvatar: _selectedAvatar,
            );
      }
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(successSnackBar(context: context, text: 'Team created'));
        context.pop();
      }
    } on InvalidRequestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(errorSnackBar(context: context, text: e.message));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onUpdateTeamPressed() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await ref
          .read(teamProviderProvider.notifier)
          .updateTeamNameOrAvatar(
            teamId: widget.team!.teamId,
            newTeamName: _teamNameController.text,
            teamAvatar: _selectedAvatar,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(successSnackBar(context: context, text: 'Team updated'));
        context.pop();
      }
    } on Exception catch (e) {
      if (context.mounted) {
        _logger.severe('Could not update the team', e);
        errorSnackBar(
          context: context,
          text: 'Something went wrong. Please try again later',
        );
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

  void _onFieldChanged(String _) {
    if (!_isDirty) {
      setState(() {
        _isDirty = true;
      });
    }
  }
}
