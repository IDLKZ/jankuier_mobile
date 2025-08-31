import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/field/field_party_entity.dart';
import '../../parameters/all_field_party_parameter.dart';

class AllFieldPartyCase
    extends UseCaseWithParams<List<FieldPartyEntity>, AllFieldPartyParameter> {
  final FieldInterface _fieldInterface;
  const AllFieldPartyCase(this._fieldInterface);

  @override
  ResultFuture<List<FieldPartyEntity>> call(AllFieldPartyParameter params) {
    return _fieldInterface.allFieldParty(params);
  }
}