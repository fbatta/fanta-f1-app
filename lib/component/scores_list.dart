import 'package:fanta_f1/component/error_card.dart';
import 'package:fanta_f1/component/team_avatar_small.dart';
import 'package:flutter/material.dart';

class ScoresAndAvatars {
  final String name;
  final double score;
  final String? avatar;
  final Function()? onPressed;

  ScoresAndAvatars({
    required this.name,
    required this.score,
    required this.avatar,
    this.onPressed,
  });
}

Widget scoresList(List<ScoresAndAvatars> scoresAndAvatars) {
  if (scoresAndAvatars.isEmpty) {
    return ErrorCard(message: 'No scores found');
  }
  return Builder(
    builder: (context) {
      return Column(
        children: [
          SizedBox(
            height: 165,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset('assets/images/podium.png'),
                Positioned(
                  top: 15,
                  child: InkWell(
                    onTap: scoresAndAvatars[0].onPressed,
                    child: Column(
                      children: [
                        teamAvatarSmall(scoresAndAvatars[0].avatar),
                        SizedBox(
                          width: 120,
                          child: Text(
                            scoresAndAvatars[0].name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _teamScore(scoresAndAvatars[0].score),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 30,
                  child: InkWell(
                    onTap: scoresAndAvatars[1].onPressed,
                    child: Column(
                      children: [
                        teamAvatarSmall(scoresAndAvatars[1].avatar),
                        SizedBox(
                          width: 110,
                          child: Text(
                            scoresAndAvatars[1].name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _teamScore(scoresAndAvatars[1].score),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 40,
                  child: InkWell(
                    onTap: scoresAndAvatars[2].onPressed,
                    child: Column(
                      children: [
                        teamAvatarSmall(scoresAndAvatars[2].avatar),
                        SizedBox(
                          width: 110,
                          child: Text(
                            scoresAndAvatars[2].name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _teamScore(scoresAndAvatars[2].score),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          ...ListTile.divideTiles(
            context: context,
            tiles: scoresAndAvatars
                .sublist(3)
                .map<Widget>(
                  (scoreAndAvatar) => InkWell(
                    onTap: scoreAndAvatar.onPressed,
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      minVerticalPadding: 0,
                      leading: teamAvatarSmall(scoreAndAvatar.avatar),
                      title: Text(scoreAndAvatar.name),
                      trailing: _teamScore(scoreAndAvatar.score),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );
    },
  );
}

Widget _teamScore(double score) {
  return Builder(
    builder: (context) {
      return Text(
        score.toString(),
        style: Theme.of(context).textTheme.labelLarge,
      );
    },
  );
}
