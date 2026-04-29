// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_weekend_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RaceWeekendProvider)
final raceWeekendProviderProvider = RaceWeekendProviderProvider._();

final class RaceWeekendProviderProvider
    extends
        $AsyncNotifierProvider<RaceWeekendProvider, RaceWeekendProviderModel> {
  RaceWeekendProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'raceWeekendProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$raceWeekendProviderHash();

  @$internal
  @override
  RaceWeekendProvider create() => RaceWeekendProvider();
}

String _$raceWeekendProviderHash() =>
    r'19b12c25d8ff336a24d464270653f4460037380d';

abstract class _$RaceWeekendProvider
    extends $AsyncNotifier<RaceWeekendProviderModel> {
  FutureOr<RaceWeekendProviderModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<RaceWeekendProviderModel>,
              RaceWeekendProviderModel
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<RaceWeekendProviderModel>,
                RaceWeekendProviderModel
              >,
              AsyncValue<RaceWeekendProviderModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
