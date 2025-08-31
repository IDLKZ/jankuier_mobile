import 'package:jankuier_mobile/features/services/data/entities/academy/get_full_academy_entity.dart';
import 'package:jankuier_mobile/features/services/domain/interface/academy_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';

class GetFullAcademyDetailCase
    extends UseCaseWithParams<GetFullAcademyEntity, int> {
  final AcademyInterface _academyInterface;
  const GetFullAcademyDetailCase(this._academyInterface);

  @override
  ResultFuture<GetFullAcademyEntity> call(int academyId) {
    return _academyInterface.getFullAcademyDetailById(academyId);
  }
}