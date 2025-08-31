import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/academy/academy_entity.dart';
import '../../data/entities/academy/academy_group_schedule_entity.dart';
import '../../data/entities/academy/get_full_academy_entity.dart';
import '../parameters/academy_group_schedule_by_day_parameter.dart';
import '../parameters/paginate_academy_parameter.dart';

abstract class AcademyInterface {
  ResultFuture<Pagination<AcademyEntity>> paginateAcademy(
      PaginateAcademyParameter parameter);
  
  ResultFuture<GetFullAcademyEntity> getFullAcademyDetailById(int academyId);
  
  ResultFuture<List<AcademyGroupScheduleEntity>> getAcademyGroupScheduleByDayAndGroups(
      AcademyGroupScheduleByDayParameter parameter);
}