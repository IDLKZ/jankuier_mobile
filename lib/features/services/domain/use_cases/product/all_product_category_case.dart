import 'package:jankuier_mobile/features/services/domain/interface/product_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/product/product_category_entity.dart';
import '../../../data/entities/product/product_entity.dart';
import '../../parameters/all_product_category_parameter.dart';
import '../../parameters/all_product_parameter.dart';

class AllProductCategoryCase extends UseCaseWithParams<
    List<ProductCategoryEntity>, AllProductCategoryParameter> {
  final ProductInterface _productInterface;
  const AllProductCategoryCase(this._productInterface);

  @override
  ResultFuture<List<ProductCategoryEntity>> call(
      AllProductCategoryParameter params) {
    return _productInterface.allProductCategory(params);
  }
}
