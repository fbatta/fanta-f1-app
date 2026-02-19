// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LobbyProvider)
final lobbyProviderProvider = LobbyProviderProvider._();

final class LobbyProviderProvider
    extends $AsyncNotifierProvider<LobbyProvider, List<Lobby>> {
  LobbyProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lobbyProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lobbyProviderHash();

  @$internal
  @override
  LobbyProvider create() => LobbyProvider();
}

String _$lobbyProviderHash() => r'f1f988571b45fb42ea05f86410183474df92f313';

abstract class _$LobbyProvider extends $AsyncNotifier<List<Lobby>> {
  FutureOr<List<Lobby>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Lobby>>, List<Lobby>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Lobby>>, List<Lobby>>,
              AsyncValue<List<Lobby>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
