import 'package:fanta_f1/component/error_snack_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/component/success_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CreateUser extends ConsumerStatefulWidget {
  const CreateUser({super.key});

  @override
  ConsumerState createState() => _CreateUserState();
}

class _CreateUserState extends ConsumerState<CreateUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _getIt = GetIt.instance;
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
      appBar: AppBar(title: Text('Sign up')),
      floatingActionButton: _createUserFab(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Nickname',
                labelText: 'Nickname',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: _nameValidator,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: _emailValidator,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: _passwordValidator,
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
      ),
    );
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a nickname';
    }
    if (value.length < 3) {
      return 'Nickname must be at least 3 characters';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Widget? _createUserFab() {
    return FloatingActionButton.extended(
      onPressed: _onCreateUserPressed,
      label: Text('Sign up'),
      icon: Icon(Icons.person_add),
    );
  }

  Future<void> _onCreateUserPressed() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await credential.user!.updateDisplayName(_nameController.text);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(successSnackBar(context: context, text: 'User created'));
        context.pop();
      }
    } catch (e) {
      // TODO: report error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(
            context: context,
            text: 'Failed to sign up. Please try again later',
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
