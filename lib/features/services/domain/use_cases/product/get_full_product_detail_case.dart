import 'package:jankuier_mobile/features/services/data/entities/product/full_product_entity.dart';
import 'package:jankuier_mobile/features/services/domain/interface/product_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';

class GetFullProductDetailCase
    extends UseCaseWithParams<FullProductEntity, int> {
  final ProductInterface _productInterface;
  const GetFullProductDetailCase(this._productInterface);

  @override
  ResultFuture<FullProductEntity> call(int productId) {
    return _productInterface.getFullProductDetail(productId);
  }
}
