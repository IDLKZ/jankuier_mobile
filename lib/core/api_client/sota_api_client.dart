import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/sota_token_entity.dart';
import 'package:jankuier_mobile/core/constants/sota_api_constants.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';

import '../constants/hive_constants.dart';
import '../errors/exception.dart';
import '../utils/sota_http_utils.dart';

class SotaApiClient {
  final httpUtils = SotaHttpUtil();
  final hiveUtils = HiveUtils();

  Future<String> getSotaToken() async {
    try {
      final cached =
          await hiveUtils.get<Map<String, dynamic>>(HiveConstant.SotaTokenKey);
      if (cached != null) {
        final cachedToken = SotaTokenEntity.fromJson(cached);
        return cachedToken.access;
      }

      final response = await httpUtils.post(
        SotaApiConstant.GetTokenURL,
        data: {
          'email': SotaApiConstant.AuthEmail,
          'password': SotaApiConstant.AuthPassword,
        },
      );

      final tokenData = SotaTokenEntity.fromJson(response);

      await hiveUtils.put<Map<String, dynamic>>(
        HiveConstant.SotaTokenKey,
        tokenData.toJson(),
        ttl: const Duration(minutes: SotaApiConstant.SaveTokenSession),
      );
      return tokenData.access;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
