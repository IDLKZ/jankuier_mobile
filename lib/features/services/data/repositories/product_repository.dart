import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/full_product_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_category_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_product_category_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_product_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_product_parameter.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/interface/product_interface.dart';
import '../datasources/product_datasource.dart';
import '../entities/product/product_entity.dart';

class ProductRepository implements ProductInterface {
  final ProductDSInterface productDSInterface;

  const ProductRepository(this.productDSInterface);

  @override
  ResultFuture<List<ProductEntity>> allProduct(
      AllProductParameter parameter) async {
    try {
      final result = await this.productDSInterface.allProduct(parameter);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<FullProductEntity> getFullProductDetail(int productId) async {
    try {
      final result =
          await this.productDSInterface.getFullProductDetail(productId);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<List<ProductCategoryEntity>> allProductCategory(
      AllProductCategoryParameter parameter) async {
    try {
      final result =
          await this.productDSInterface.allProductCategory(parameter);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<Pagination<ProductEntity>> paginateProduct(
      PaginateProductParameter parameter) async {
    try {
      final result = await this.productDSInterface.paginateProduct(parameter);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }
}
