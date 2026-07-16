import 'package:flutter/material.dart';

Widget sectionHeader(String text) {
  return Builder(
    builder: (context) {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! + 1.5,
        ),
      );
    },
  );
}
