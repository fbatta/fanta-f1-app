import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamSelectModalBottomSheet extends ConsumerStatefulWidget {
  const TeamSelectModalBottomSheet({super.key});

  @override
  ConsumerState createState() => _TeamSelectModalBottomSheetState();
}

class _TeamSelectModalBottomSheetState
    extends ConsumerState<TeamSelectModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(teamProviderProvider);

    if (teams.isLoading || teams.isRefreshing) {
      return SizedBox(
        height: 200,
        child: SpinnerCentered(text: 'Loading teams...'),
      );
    }

    if (teams.hasError) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text('Something went wrong, please try again later.'),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Select team to lineup for:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              itemCount: teams.requireValue.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.of(
                  context,
                ).pop(teams.requireValue.values.elementAt(index).teamId),
                child: ListTile(
                  title: Text(
                    teams.requireValue.values.elementAt(index).teamName,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
