import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';
import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';

class GetFieldPartyCase
    extends UseCaseWithParams<FieldPartyEntity, int> {
  final FieldInterface _fieldInterface;
  const GetFieldPartyCase(this._fieldInterface);

  @override
  ResultFuture<FieldPartyEntity> call(int fieldPartyId) {
    return _fieldInterface.getFieldParty(fieldPartyId);
  }
}