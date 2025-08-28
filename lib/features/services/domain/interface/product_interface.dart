import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/product/full_product_entity.dart';
import '../../data/entities/product/product_category_entity.dart';
import '../../data/entities/product/product_entity.dart';
import '../parameters/all_product_category_parameter.dart';
import '../parameters/all_product_parameter.dart';
import '../parameters/paginate_product_parameter.dart';

abstract class ProductInterface {
  ResultFuture<Pagination<ProductEntity>> paginateProduct(
      PaginateProductParameter parameter);
  ResultFuture<List<ProductEntity>> allProduct(AllProductParameter parameter);
  ResultFuture<FullProductEntity> getFullProductDetail(int productId);
  ResultFuture<List<ProductCategoryEntity>> allProductCategory(
      AllProductCategoryParameter parameter);
}
