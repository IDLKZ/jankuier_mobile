enum Flavor {
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  final String apiBaseUrl;
  final String apiVersion;
  final bool enableLogging;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String appName,
    required String apiBaseUrl,
    required String apiVersion,
    required bool enableLogging,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor: flavor,
      appName: appName,
      apiBaseUrl: apiBaseUrl,
      apiVersion: apiVersion,
      enableLogging: enableLogging,
    );
    return _instance!;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
    required this.apiVersion,
    required this.enableLogging,
  });

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  static bool isDevelopment() => _instance?.flavor == Flavor.dev;
  static bool isProduction() => _instance?.flavor == Flavor.prod;
}

// Конфигурации для разных окружений
class DevFlavorConfig {
  static void setup() {
    FlavorConfig(
      flavor: Flavor.dev,
      appName: 'Jankuier Dev',
      apiBaseUrl: 'https://api-dev.example.com',
      apiVersion: '/v1',
      enableLogging: true,
    );
  }
}

class ProdFlavorConfig {
  static void setup() {
    FlavorConfig(
      flavor: Flavor.prod,
      appName: 'Jankuier',
      apiBaseUrl: 'https://api.example.com',
      apiVersion: '/v1',
      enableLogging: false,
    );
  }
} 