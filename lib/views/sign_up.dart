import 'package:fanta_f1/component/error_snack_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/component/success_snack_bar.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/validator/password_validator.dart';
import 'package:fanta_f1/validator/username_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  bool _isLoading = false;
  String? _usernameErrorText;
  String? _passwordErrorText;
  String? _verifyPasswordErrorText;

  @override
  void initState() {
    _auth = _getIt();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    _displayNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      floatingActionButton: _createUserFab(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      autofillHints: [
                        AutofillHints.email,
                        AutofillHints.newUsername,
                      ],
                      autofocus: true,
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.email),
                      ),
                      validator: usernameValidator,
                      onChanged: _onUsernameChanged,
                      forceErrorText: _usernameErrorText,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      autofillHints: [AutofillHints.newPassword],
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.password),
                      ),
                      obscureText: true,
                      validator: passwordValidator,
                      onChanged: _onPasswordChanged,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      autofillHints: [AutofillHints.newPassword],
                      controller: _verifyPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Re-type password',
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.password),
                      ),
                      obscureText: true,
                      validator: _verifyPasswordValidator,
                      onChanged: _onVerifyPasswordChanged,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      autofillHints: [AutofillHints.nickname],
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Display name',
                        border: OutlineInputBorder(),
                        hintText:
                            'This is how you will appear to other players',
                      ),
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
    );
  }

  Widget _createUserFab() {
    return FloatingActionButton.extended(
      onPressed: _onSignUpPressed,
      label: Text('Sign up'),
      icon: Icon(Icons.person_add),
    );
  }

  void _onUsernameChanged(String value) {
    if (_usernameErrorText != null) {
      setState(() {
        _usernameErrorText = null;
      });
    }
  }

  void _onPasswordChanged(String value) {
    if (_passwordErrorText != null) {
      setState(() {
        _passwordErrorText = null;
      });
    }
  }

  void _onVerifyPasswordChanged(String value) {
    if (_verifyPasswordErrorText != null) {
      setState(() {
        _verifyPasswordErrorText = null;
      });
    }
  }

  String? _verifyPasswordValidator(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _onSignUpPressed() async {
    try {
      final bool isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      await userCredential.user?.updateDisplayName(_displayNameController.text);
      if (userCredential.user != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(successSnackBar(context: context, text: 'User created'));
        context.goNamed(RouteNames.signIn.name);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          setState(() {
            _usernameErrorText = 'Email already in use';
          });
          break;
        case 'invalid-email':
          setState(() {
            _usernameErrorText = 'Invalid email';
          });
          break;
        default:
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              errorSnackBar(
                context: context,
                text: 'Failed to sign up. Please try again later',
              ),
            );
          }
          break;
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
