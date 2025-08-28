import 'package:jankuier_mobile/features/services/domain/interface/product_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/product/product_entity.dart';
import '../../parameters/all_product_parameter.dart';

class AllProductCase
    extends UseCaseWithParams<List<ProductEntity>, AllProductParameter> {
  final ProductInterface _productInterface;
  const AllProductCase(this._productInterface);

  @override
  ResultFuture<List<ProductEntity>> call(AllProductParameter params) {
    return _productInterface.allProduct(params);
  }
}
