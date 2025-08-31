import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/common/entities/pagination_entity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/field/field_entity.dart';
import '../../parameters/paginate_field_parameter.dart';

class PaginateFieldCase extends UseCaseWithParams<Pagination<FieldEntity>,
    PaginateFieldParameter> {
  final FieldInterface _fieldInterface;
  const PaginateFieldCase(this._fieldInterface);

  @override
  ResultFuture<Pagination<FieldEntity>> call(
      PaginateFieldParameter params) {
    return _fieldInterface.paginateField(params);
  }
}