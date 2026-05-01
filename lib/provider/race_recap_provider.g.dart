// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_recap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RaceRecapProvider)
final raceRecapProviderProvider = RaceRecapProviderFamily._();

final class RaceRecapProviderProvider
    extends $AsyncNotifierProvider<RaceRecapProvider, RaceRecap?> {
  RaceRecapProviderProvider._({
    required RaceRecapProviderFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'raceRecapProviderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$raceRecapProviderHash();

  @override
  String toString() {
    return r'raceRecapProviderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RaceRecapProvider create() => RaceRecapProvider();

  @override
  bool operator ==(Object other) {
    return other is RaceRecapProviderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$raceRecapProviderHash() => r'ab7b6be7e6d191d17a45509c7c09c8495b9f1999';

final class RaceRecapProviderFamily extends $Family
    with
        $ClassFamilyOverride<
          RaceRecapProvider,
          AsyncValue<RaceRecap?>,
          RaceRecap?,
          FutureOr<RaceRecap?>,
          String
        > {
  RaceRecapProviderFamily._()
    : super(
        retry: null,
        name: r'raceRecapProviderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RaceRecapProviderProvider call(String raceId) =>
      RaceRecapProviderProvider._(argument: raceId, from: this);

  @override
  String toString() => r'raceRecapProviderProvider';
}

abstract class _$RaceRecapProvider extends $AsyncNotifier<RaceRecap?> {
  late final _$args = ref.$arg as String;
  String get raceId => _$args;

  FutureOr<RaceRecap?> build(String raceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RaceRecap?>, RaceRecap?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RaceRecap?>, RaceRecap?>,
              AsyncValue<RaceRecap?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
