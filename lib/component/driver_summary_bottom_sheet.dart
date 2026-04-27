import 'package:fanta_f1/dto/driver_summary/driver_summary.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:flutter/material.dart';
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
    return Container();
  }
}
