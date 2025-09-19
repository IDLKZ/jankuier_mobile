import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../constants/hive_constants.dart';
import '../di/injection.dart';
import '../../features/auth/data/entities/user_entity.dart';

@injectable
class HiveUtils {
  final HiveInterface hive = getIt<HiveInterface>();

  final Map<String, Box> _openedBoxes = {};

  Future<Box> _getBox(String boxName) async {
    if (_openedBoxes.containsKey(boxName)) {
      return _openedBoxes[boxName]!;
    } else {
      final box = await hive.openBox(boxName);
      _openedBoxes[boxName] = box;
      return box;
    }
  }

  Future<void> put<T>(String key, T value,
      {String box = HiveConstant.appBox, Duration? ttl}) async {
    final b = await _getBox(box);
    final expiresAt =
        ttl != null ? DateTime.now().add(ttl).millisecondsSinceEpoch : null;
    await b.put(key, {'data': value, 'expiresAt': expiresAt});
  }

  Future<T?> get<T>(String key, {String box = HiveConstant.appBox}) async {
    final b = await _getBox(box);
    final raw = b.get(key);
    if (raw is Map && raw.containsKey('data')) {
      final expiresAt = raw['expiresAt'];
      if (expiresAt != null &&
          DateTime.now().millisecondsSinceEpoch > expiresAt) {
        await b.delete(key);
        return null;
      }
      final data = raw['data'];
      if (data is Map && T.toString().contains('Map<String, dynamic>')) {
        return Map<String, dynamic>.from(data) as T;
      }
      return data as T;
    }
    return raw as T?;
  }

  Future<void> delete(String key, {String box = HiveConstant.appBox}) async {
    final b = await _getBox(box);
    await b.delete(key);
  }

  Future<void> clearBox(String box) async {
    final b = await _getBox(box);
    await b.clear();
  }

  // Auth token methods
  Future<void> setAccessToken(String token) async {
    await put(HiveConstant.accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    return await get<String>(HiveConstant.accessTokenKey);
  }

  Future<void> clearAccessToken() async {
    await delete(HiveConstant.accessTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await put(HiveConstant.refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    return await get<String>(HiveConstant.refreshTokenKey);
  }

  Future<void> clearRefreshToken() async {
    await delete(HiveConstant.refreshTokenKey);
  }

  Future<void> clearAllTokens() async {
    await clearAccessToken();
    await clearRefreshToken();
  }

  // User methods
  Future<void> setCurrentUser(UserEntity user) async {
    await put(HiveConstant.currentUserKey, user);
  }

  Future<UserEntity?> getCurrentUser() async {
    return await get<UserEntity>(HiveConstant.currentUserKey);
  }

  Future<void> clearCurrentUser() async {
    await delete(HiveConstant.currentUserKey);
  }

  Future<void> clearAllUserData() async {
    await clearAllTokens();
    await clearCurrentUser();
  }
}
