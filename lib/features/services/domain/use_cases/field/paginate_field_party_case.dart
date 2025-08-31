import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/common/entities/pagination_entity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/field/field_party_entity.dart';
import '../../parameters/paginate_field_party_parameter.dart';

class PaginateFieldPartyCase extends UseCaseWithParams<Pagination<FieldPartyEntity>,
    PaginateFieldPartyParameter> {
  final FieldInterface _fieldInterface;
  const PaginateFieldPartyCase(this._fieldInterface);

  @override
  ResultFuture<Pagination<FieldPartyEntity>> call(
      PaginateFieldPartyParameter params) {
    return _fieldInterface.paginateFieldParty(params);
  }
}