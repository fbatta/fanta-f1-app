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
    extends $AsyncNotifierProvider<RaceWeekendProvider, List<Race>> {
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
    r'973a7aff9cd61a62df361148aa8988391f69a38c';

abstract class _$RaceWeekendProvider extends $AsyncNotifier<List<Race>> {
  FutureOr<List<Race>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Race>>, List<Race>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Race>>, List<Race>>,
              AsyncValue<List<Race>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
