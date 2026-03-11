import 'package:fanta_f1/dto/team/team.dart';
import 'package:flutter/material.dart';

Widget teamAvatarSmall(Team standing, {double height = 30, double width = 30}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: standing.teamAvatarUrl != null
            ? NetworkImage(standing.teamAvatarUrl!)
            : AssetImage('assets/images/idgaf1_default_avatar.png'),
      ),
    ),
  );
}
