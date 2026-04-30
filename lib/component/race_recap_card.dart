import 'package:fanta_f1/component/section_header.dart';
import 'package:fanta_f1/dto/race_recap/race_recap.dart';
import 'package:fanta_f1/provider/race_recap_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RaceRecapCard extends ConsumerWidget {
  final String raceId;
  const RaceRecapCard({super.key, required this.raceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recapAsync = ref.watch(raceRecapProviderProvider(raceId));

    return recapAsync.when(
      data: (recap) {
        if (recap == null) {
          return const SizedBox.shrink();
        }

        return _buildRecapCard(context, recap);
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildRecapCard(BuildContext context, RaceRecap recap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        sectionHeader('Race weekend recap'),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  MarkdownBody(
                    data: recap.recapParagraphs.join('\n\n'),
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                          p: Theme.of(context).textTheme.bodyMedium,
                          blockquoteDecoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          blockquote: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                          strong: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
