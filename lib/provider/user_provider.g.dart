// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserProvider)
final userProviderProvider = UserProviderProvider._();

final class UserProviderProvider
    extends $AsyncNotifierProvider<UserProvider, User?> {
  UserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userProviderHash();

  @$internal
  @override
  UserProvider create() => UserProvider();
}

String _$userProviderHash() => r'ed9576c9e7c25ad0f8cbacd3e8f272780d664dc5';

abstract class _$UserProvider extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
