// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PreferencesProvider)
final preferencesProviderProvider = PreferencesProviderProvider._();

final class PreferencesProviderProvider
    extends $AsyncNotifierProvider<PreferencesProvider, AppPreferences> {
  PreferencesProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesProviderHash();

  @$internal
  @override
  PreferencesProvider create() => PreferencesProvider();
}

String _$preferencesProviderHash() =>
    r'85b32c35e8183bfe6bceffabe81cc83fb880d129';

abstract class _$PreferencesProvider extends $AsyncNotifier<AppPreferences> {
  FutureOr<AppPreferences> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppPreferences>, AppPreferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppPreferences>, AppPreferences>,
              AsyncValue<AppPreferences>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
