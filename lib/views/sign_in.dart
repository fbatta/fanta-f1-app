import 'dart:core';

import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../validator/username_validator.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String? usernameErrorText;
  String? passwordErrorText;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _SignInState() {
    _auth = _getIt<FirebaseAuth>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autofillHints: [AutofillHints.email, AutofillHints.username],
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    validator: usernameValidator,
                    onChanged: _onUsernameChanged,
                    forceErrorText: usernameErrorText,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    autofillHints: [AutofillHints.password],
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.password),
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.send,
                    onChanged: _onPasswordChanged,
                    onFieldSubmitted: (_) => _onSignInPressed(),
                    forceErrorText: passwordErrorText,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text('Forgot password'),
                        onPressed: () => context.pushNamed(RouteNames.forgotPassword.toString()),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(onPressed: _onSignInPressed, child: Text('Sign In')),
                    ],
                  )
                ],
              ),
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

  void _onSignInPressed() async {
    try {
      final bool isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      await _auth.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      TextInput.finishAutofillContext();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          setState(() {
            usernameErrorText = 'Invalid email';
          });
          break;
        case 'user-not-found':
          setState(() {
            usernameErrorText = 'User not found';
          });
          break;
        case 'invalid-credential':
          setState(() {
            usernameErrorText = e.message;
          });
          break;
        case 'wrong-password':
          setState(() {
            passwordErrorText = 'Wrong password';
          });
          break;
        case 'user-disabled':
          setState(() {
            usernameErrorText = 'User disabled';
          });
          break;
        default:
          setState(() {
            usernameErrorText =
                'An unknown error occurred. Try again in a little bit';
          });
          break;
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
