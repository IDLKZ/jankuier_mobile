import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/field/field_schedule_record_entity.dart';
import '../../parameters/field_party_schedule_preview_parameter.dart';

class GetFieldPartySchedulePreviewCase
    extends UseCaseWithParams<ScheduleGeneratorResponseEntity, FieldPartySchedulePreviewParameter> {
  final FieldInterface _fieldInterface;
  const GetFieldPartySchedulePreviewCase(this._fieldInterface);

  @override
  ResultFuture<ScheduleGeneratorResponseEntity> call(FieldPartySchedulePreviewParameter params) {
    return _fieldInterface.getFieldPartySchedulePreview(params);
  }
}