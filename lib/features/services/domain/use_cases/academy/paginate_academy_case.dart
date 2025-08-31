import 'package:jankuier_mobile/features/services/domain/interface/academy_interface.dart';
import '../../../../../core/common/entities/pagination_entity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/academy/academy_entity.dart';
import '../../parameters/paginate_academy_parameter.dart';

class PaginateAcademyCase extends UseCaseWithParams<Pagination<AcademyEntity>,
    PaginateAcademyParameter> {
  final AcademyInterface _academyInterface;
  const PaginateAcademyCase(this._academyInterface);

  @override
  ResultFuture<Pagination<AcademyEntity>> call(
      PaginateAcademyParameter params) {
    return _academyInterface.paginateAcademy(params);
  }
}