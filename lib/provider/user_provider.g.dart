// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserProvider)
const userProviderProvider = UserProviderProvider._();

final class UserProviderProvider
    extends $AsyncNotifierProvider<UserProvider, User?> {
  const UserProviderProvider._()
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

String _$userProviderHash() => r'f2df667b57cfa4688a5bd03c9458d6c12f4f5869';

abstract class _$UserProvider extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
