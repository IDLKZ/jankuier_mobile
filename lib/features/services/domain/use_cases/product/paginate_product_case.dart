import 'package:jankuier_mobile/features/services/domain/interface/product_interface.dart';
import '../../../../../core/common/entities/pagination_entity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/product/product_entity.dart';
import '../../parameters/paginate_product_parameter.dart';

class PaginateProductCase extends UseCaseWithParams<Pagination<ProductEntity>,
    PaginateProductParameter> {
  final ProductInterface _productInterface;
  const PaginateProductCase(this._productInterface);

  @override
  ResultFuture<Pagination<ProductEntity>> call(
      PaginateProductParameter params) {
    return _productInterface.paginateProduct(params);
  }
}
