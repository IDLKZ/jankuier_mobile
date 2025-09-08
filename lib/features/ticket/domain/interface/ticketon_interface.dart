import '../../../../core/utils/typedef.dart';
import '../../data/entities/shows/ticketon_shows_entity.dart';
import '../parameters/ticketon_get_shows_parameter.dart';

abstract class TicketonInterface {
  ResultFuture<TicketonShowsDataEntity> getShows(
      TicketonGetShowsParameter parameter);
}