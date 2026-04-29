class EnvironmentUtils {
  static bool get isDebugMode => !bool.fromEnvironment('dart.vm.product');
}
