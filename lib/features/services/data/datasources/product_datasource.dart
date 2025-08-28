import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/full_product_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_category_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_product_category_parameter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../domain/parameters/all_product_parameter.dart';
import '../../domain/parameters/paginate_product_parameter.dart';

abstract class ProductDSInterface {
  Future<Pagination<ProductEntity>> paginateProduct(
      PaginateProductParameter parameter);
  Future<List<ProductEntity>> allProduct(AllProductParameter parameter);
  Future<FullProductEntity> getFullProductDetail(int productId);
  Future<List<ProductCategoryEntity>> allProductCategory(
      AllProductCategoryParameter parameter);
}

class ProductDSImpl implements ProductDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<List<ProductEntity>> allProduct(AllProductParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.GetAllProductsUrl,
          queryParameters: parameter.toQueryParameters());
      final result = ProductListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<FullProductEntity> getFullProductDetail(int productId) async {
    try {
      final response =
          await httpUtils.get(ApiConstant.GetFullProductDetailUrl(productId));
      final result = FullProductEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<ProductEntity>> paginateProduct(
      PaginateProductParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.PaginateAllProductsUrl,
          queryParameters: parameter.toQueryParameters());
      final result =
          Pagination<ProductEntity>.fromJson(response, ProductEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductCategoryEntity>> allProductCategory(
      AllProductCategoryParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.GetAllProductsUrl,
          queryParameters: parameter.toMap());
      final result = ProductCategoryListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
