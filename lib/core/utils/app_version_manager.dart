import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants/hive_constants.dart';
import '../di/injection.dart';
import 'hive_utils.dart';
import '../../features/local_auth/domain/repository/local_auth_interface.dart';

/// Менеджер версий приложения
///
/// Отслеживает версию приложения и выполняет необходимые действия
/// при первой установке, переустановке или обновлении.
@injectable
class AppVersionManager {
  final HiveUtils _hiveUtils = getIt<HiveUtils>();
  final LocalAuthInterface _localAuthInterface = getIt<LocalAuthInterface>();

  /// Проверяет версию приложения и выполняет необходимые действия
  ///
  /// Сравнивает текущую версию приложения с сохраненной в Hive.
  /// Если версии отличаются или версия не сохранена (первая установка),
  /// очищает FlutterSecureStorage и сохраняет новую версию.
  ///
  /// **Используется при:**
  /// - Первой установке приложения
  /// - Переустановке приложения
  /// - Обновлении приложения на новую версию
  Future<void> checkAndHandleAppVersion() async {
    try {
      // Получаем текущую версию приложения
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;
      final String currentBuildNumber = packageInfo.buildNumber;
      final String currentFullVersion = '$currentVersion+$currentBuildNumber';

      // Получаем сохраненную версию из Hive
      final String? savedVersion =
          await _hiveUtils.get<String>(HiveConstant.appVersionKey);

      // Если версия отличается или не сохранена (первая установка/переустановка/обновление)
      if (savedVersion == null || savedVersion != currentFullVersion) {
        print('🔄 Версия приложения изменилась:');
        print('   Сохраненная версия: ${savedVersion ?? "отсутствует (первая установка)"}');
        print('   Текущая версия: $currentFullVersion');

        // Очищаем данные локальной аутентификации из FlutterSecureStorage
        final result = await _localAuthInterface.clearLocalAuthData();
        result.fold(
          (failure) {
            print('❌ Ошибка при очистке данных локальной аутентификации: ${failure.message}');
          },
          (success) {
            if (success) {
              print('✅ Данные локальной аутентификации успешно очищены');
            }
          },
        );

        // Сохраняем новую версию приложения
        await _hiveUtils.put<String>(
          HiveConstant.appVersionKey,
          currentFullVersion,
        );
        print('✅ Новая версия приложения сохранена: $currentFullVersion');
      } else {
        print('✅ Версия приложения не изменилась: $currentFullVersion');
      }
    } catch (e) {
      print('❌ Ошибка при проверке версии приложения: $e');
    }
  }
}
