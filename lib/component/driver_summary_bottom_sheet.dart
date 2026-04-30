import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_summary/driver_summary.dart';
import 'package:fanta_f1/helper/color_utils.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverSummaryBottomSheet extends ConsumerStatefulWidget {
  final String driverId;
  const DriverSummaryBottomSheet({super.key, required this.driverId});

  @override
  ConsumerState createState() => _DriverSummaryBottomSheetState();
}

class _DriverSummaryBottomSheetState
    extends ConsumerState<DriverSummaryBottomSheet> {
  late final Future<DriverSummary?> _driverSummaryFuture;

  @override
  void initState() {
    _driverSummaryFuture = ref
        .read(driverProviderProvider.notifier)
        .getDriverSummary(widget.driverId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final driverProvider = ref.watch(driverProviderProvider);

    return FutureBuilder<DriverSummary?>(
      future: _driverSummaryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text('Something went wrong, please try again later.'),
            ),
          );
        }

        final summary = snapshot.data!;
        final driversMap = driverProvider.requireValue;
        final driverEntry = driversMap.entries.firstWhere(
          (el) => el.key.driverId == widget.driverId,
          orElse: () => driversMap.entries.first,
        );
        final driver = driverEntry.key;
        final driverCost = driverEntry.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _driverAvatar(driver),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary.driverName,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${summary.driverNumber} · ${driver.teamName}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: ColorUtils.convertHexToColor(
                                  driver.teamColour,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$${driverCost.driverCost.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              MarkdownBody(
                data:
                    '**AI-generated summary**\n\n${summary.summaryParagraphs.join('\n\n')}',
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
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                      strong: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _driverAvatar(Driver driver) {
    if (driver.driverAvatar == 'UNKNOWN') {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          image: DecorationImage(
            image: const AssetImage('assets/images/unknown_driver_avatar.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return ClipOval(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Image.network(
          driver.driverAvatar,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}
