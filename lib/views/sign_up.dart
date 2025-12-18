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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyPasswordController =
      TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  bool isLoading = false;
  String? usernameErrorText;
  String? passwordErrorText;
  String? verifyPasswordErrorText;
  String? displayNameErrorText;

  @override
  void initState() {
    _auth = _getIt<FirebaseAuth>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    verifyPasswordController.dispose();
    displayNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email),
                  ),
                  validator: usernameValidator,
                  onChanged: _onUsernameChanged,
                  forceErrorText: usernameErrorText,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autofillHints: [AutofillHints.newPassword],
                  controller: passwordController,
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
                  controller: verifyPasswordController,
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
                  controller: displayNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Display name',
                    border: OutlineInputBorder(),
                    hintText: 'This is how you will appear to other players',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onUsernameChanged(String value) {
    if (usernameErrorText != null) {
      setState(() {
        usernameErrorText = null;
      });
    }
  }

  void _onPasswordChanged(String value) {
    if (passwordErrorText != null) {
      setState(() {
        passwordErrorText = null;
      });
    }
  }

  void _onVerifyPasswordChanged(String value) {
    if (verifyPasswordErrorText != null) {
      setState(() {
        verifyPasswordErrorText = null;
      });
    }
  }

  String? _verifyPasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _onSignUpPressed() async {
    try {
      final bool isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      await userCredential.user?.updateDisplayName(displayNameController.text);
      if (userCredential.user != null && context.mounted) {
        return context.goNamed(RouteNames.home.toString());
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          setState(() {
            usernameErrorText = 'Email already in use';
          });
          break;
        case 'invalid-email':
          setState(() {
            usernameErrorText = 'Invalid email';
          });
          break;
        default:
          setState(() {
            usernameErrorText = 'Something went wrong. Please try again later';
          });
          break;
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
