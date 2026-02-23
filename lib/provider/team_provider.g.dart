// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TeamProvider)
final teamProviderProvider = TeamProviderProvider._();

final class TeamProviderProvider
    extends $AsyncNotifierProvider<TeamProvider, Map<String, Team>> {
  TeamProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamProviderHash();

  @$internal
  @override
  TeamProvider create() => TeamProvider();
}

String _$teamProviderHash() => r'264c7895d1a4a94f0cf89e7fd5454f3bae090ba6';

abstract class _$TeamProvider extends $AsyncNotifier<Map<String, Team>> {
  FutureOr<Map<String, Team>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, Team>>, Map<String, Team>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, Team>>, Map<String, Team>>,
              AsyncValue<Map<String, Team>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
