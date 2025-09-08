import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/shows/ticketon_shows_entity.dart';
import '../interface/ticketon_interface.dart';
import '../parameters/ticketon_get_shows_parameter.dart';

@injectable
class GetTicketonShowsUseCase extends UseCaseWithParams<
    TicketonShowsDataEntity, TicketonGetShowsParameter> {
  final TicketonInterface _ticketonInterface;

  const GetTicketonShowsUseCase(this._ticketonInterface);

  @override
  ResultFuture<TicketonShowsDataEntity> call(
      TicketonGetShowsParameter params) {
    return _ticketonInterface.getShows(params);
  }
}