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
    extends $AsyncNotifierProvider<LobbyProvider, Map<String, Lobby>> {
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

String _$lobbyProviderHash() => r'fd4d491dfde8423a1feb328084da46463446ca40';

abstract class _$LobbyProvider extends $AsyncNotifier<Map<String, Lobby>> {
  FutureOr<Map<String, Lobby>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, Lobby>>, Map<String, Lobby>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, Lobby>>, Map<String, Lobby>>,
              AsyncValue<Map<String, Lobby>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
