import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../validator/username_validator.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;
  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();

  String? errorText;
  bool isLoading = false;

  @override
  void initState() {
    _auth = _getIt<FirebaseAuth>();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot my password'),),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: textEditingController,
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
                  forceErrorText: errorText,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => context.goNamed(RouteNames.signIn.toString()), child: Text('Go back')),
                    const SizedBox(width: 8),
                    FilledButton(onPressed: _onPasswordResetPressed, child: Text('Reset password')),
                  ],
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  void _onUsernameChanged(String value) {
    if (errorText != null) {
      setState(() {
        errorText = null;
      });
    }
  }

  void _onPasswordResetPressed() async {
    try {
      final bool isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      await _auth.sendPasswordResetEmail(email: textEditingController.text);
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } on FirebaseAuthException catch(e) {
      switch(e.code) {
        case 'auth/invalid-email':
          setState(() {
            errorText = 'Invalid email address';
          });
          break;
        case 'auth/user-not-found':
          setState(() {
            errorText = 'User with this email not found';
          });
          break;
        default:
          setState(() {
            errorText = 'Something went wrong. Please try again later.';
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