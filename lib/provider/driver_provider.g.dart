// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverProvider)
final driverProviderProvider = DriverProviderProvider._();

final class DriverProviderProvider
    extends $AsyncNotifierProvider<DriverProvider, Map<Driver, DriverCost>> {
  DriverProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverProviderHash();

  @$internal
  @override
  DriverProvider create() => DriverProvider();
}

String _$driverProviderHash() => r'e9a3cd0e478a961bed14c62f7cf976332c95c7e3';

abstract class _$DriverProvider
    extends $AsyncNotifier<Map<Driver, DriverCost>> {
  FutureOr<Map<Driver, DriverCost>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<Driver, DriverCost>>,
              Map<Driver, DriverCost>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<Driver, DriverCost>>,
                Map<Driver, DriverCost>
              >,
              AsyncValue<Map<Driver, DriverCost>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
