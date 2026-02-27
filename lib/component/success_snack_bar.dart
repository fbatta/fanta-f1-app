import 'package:flutter/material.dart';

SnackBar successSnackBar({
  required BuildContext context,
  required String text,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Icon(Icons.check_circle_outline, color: Colors.green.shade700),
        SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.green.shade700),
        ),
      ],
    ),
    backgroundColor: Colors.lightGreen.shade100,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );
}
