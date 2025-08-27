import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/full_product_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
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
}

class ProductDSImpl implements ProductDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<List<ProductEntity>> allProduct(AllProductParameter parameter) async {
    // TODO: implement getFullProductDetail
    throw UnimplementedError();
  }

  @override
  Future<FullProductEntity> getFullProductDetail(int productId) {
    // TODO: implement getFullProductDetail
    throw UnimplementedError();
  }

  @override
  Future<Pagination<ProductEntity>> paginateProduct(
      PaginateProductParameter parameter) {
    // TODO: implement paginateProduct
    throw UnimplementedError();
  }
}
