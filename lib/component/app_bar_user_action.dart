import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarUserAction extends ConsumerWidget {
  final User? user;

  const AppBarUserAction({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RawMaterialButton(
      onPressed: () {
        // TODO: implement this
      },
      shape: CircleBorder(),
      child: user?.photoURL != null
          ? Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user!.photoURL!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Icon(Icons.person),
    );
  }
}
