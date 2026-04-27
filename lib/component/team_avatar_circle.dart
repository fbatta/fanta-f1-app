import 'package:flutter/material.dart';

Widget teamAvatarCircle(
  String? teamAvatarUrl, {
  double height = 30,
  double width = 30,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: teamAvatarUrl != null
            ? NetworkImage(teamAvatarUrl)
            : AssetImage('assets/images/idgaf1_default_avatar.png'),
        onError: (error, stackTrace) {},
      ),
    ),
  );
}
