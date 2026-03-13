// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LineupProvider)
final lineupProviderProvider = LineupProviderProvider._();

final class LineupProviderProvider
    extends $AsyncNotifierProvider<LineupProvider, void> {
  LineupProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lineupProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lineupProviderHash();

  @$internal
  @override
  LineupProvider create() => LineupProvider();
}

String _$lineupProviderHash() => r'821630fa132500012459b276205dcc4849ac5cb0';

abstract class _$LineupProvider extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
