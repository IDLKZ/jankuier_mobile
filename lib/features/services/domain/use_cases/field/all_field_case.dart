import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/field/field_entity.dart';
import '../../parameters/all_field_parameter.dart';

class AllFieldCase
    extends UseCaseWithParams<List<FieldEntity>, AllFieldParameter> {
  final FieldInterface _fieldInterface;
  const AllFieldCase(this._fieldInterface);

  @override
  ResultFuture<List<FieldEntity>> call(AllFieldParameter params) {
    return _fieldInterface.allField(params);
  }
}