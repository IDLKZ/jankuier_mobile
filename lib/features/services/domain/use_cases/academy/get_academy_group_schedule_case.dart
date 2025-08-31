import 'package:jankuier_mobile/features/services/domain/interface/academy_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/academy/academy_group_schedule_entity.dart';
import '../../parameters/academy_group_schedule_by_day_parameter.dart';

class GetAcademyGroupScheduleCase
    extends UseCaseWithParams<List<AcademyGroupScheduleEntity>, AcademyGroupScheduleByDayParameter> {
  final AcademyInterface _academyInterface;
  const GetAcademyGroupScheduleCase(this._academyInterface);

  @override
  ResultFuture<List<AcademyGroupScheduleEntity>> call(AcademyGroupScheduleByDayParameter params) {
    return _academyInterface.getAcademyGroupScheduleByDayAndGroups(params);
  }
}