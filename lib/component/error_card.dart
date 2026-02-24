import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorCard extends ConsumerWidget {
  final String message;
  const ErrorCard({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
