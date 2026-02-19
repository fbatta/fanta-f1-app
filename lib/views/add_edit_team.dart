import 'dart:io';

import 'package:fanta_f1/dto/team/team.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.team != null) {
      _teamNameController.text = widget.team!.teamName;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team == null ? 'Add Team' : 'Edit Team'),
      ),
      body: Center(
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
                    autofocus: true,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 16),
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
}
