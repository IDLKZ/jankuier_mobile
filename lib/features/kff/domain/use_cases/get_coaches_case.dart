import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_coach_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@injectable
class GetCoachesCase extends UseCaseWithParams<List<KffCoachImageEntity>, int> {
  final KffInterface _repository;

  GetCoachesCase(this._repository);

  @override
  ResultFuture<List<KffCoachImageEntity>> call(int params) async {
    return await _repository.getCoaches(params);
  }
}