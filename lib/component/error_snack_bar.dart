import 'package:flutter/material.dart';

SnackBar errorSnackBar({required BuildContext context, required String text}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ],
    ),
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );
}
