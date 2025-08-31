import 'package:jankuier_mobile/features/services/data/entities/field/field_entity.dart';
import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';

class GetFieldCase
    extends UseCaseWithParams<FieldEntity, int> {
  final FieldInterface _fieldInterface;
  const GetFieldCase(this._fieldInterface);

  @override
  ResultFuture<FieldEntity> call(int fieldId) {
    return _fieldInterface.getField(fieldId);
  }
}