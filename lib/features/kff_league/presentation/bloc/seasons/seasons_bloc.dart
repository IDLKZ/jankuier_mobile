import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_season_by_id_usecase.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_seasons_usecase.dart';
import 'seasons_event.dart';
import 'seasons_state.dart';

@injectable
class SeasonsBloc extends Bloc<SeasonsEvent, SeasonsState> {
  final GetSeasonsUseCase _getSeasonsUseCase;
  final GetSeasonByIdUseCase _getSeasonByIdUseCase;

  SeasonsBloc(this._getSeasonsUseCase, this._getSeasonByIdUseCase) : super(const SeasonsInitial()) {
    on<LoadSeasons>(_onLoadSeasons);
    on<LoadSeasonById>(_onLoadSeasonById);
    on<RefreshSeasons>(_onRefreshSeasons);
    on<ResetSeasons>(_onResetSeasons);
  }

  Future<void> _onLoadSeasons(LoadSeasons event, Emitter<SeasonsState> emit) async {
    emit(const SeasonsLoading());

    final result = await _getSeasonsUseCase(event.parameter);

    result.fold(
      (failure) => emit(SeasonsError(failure.message ?? 'Unknown error')),
      (seasons) => emit(SeasonsLoaded(seasons)),
    );
  }

  Future<void> _onLoadSeasonById(LoadSeasonById event, Emitter<SeasonsState> emit) async {
    emit(const SeasonsLoading());

    final result = await _getSeasonByIdUseCase(event.seasonId);

    result.fold(
      (failure) => emit(SeasonsError(failure.message ?? 'Unknown error')),
      (season) => emit(SingleSeasonLoaded(season)),
    );
  }

  Future<void> _onRefreshSeasons(RefreshSeasons event, Emitter<SeasonsState> emit) async {
    final result = await _getSeasonsUseCase(event.parameter);

    result.fold(
      (failure) => emit(SeasonsError(failure.message ?? 'Unknown error')),
      (seasons) => emit(SeasonsLoaded(seasons)),
    );
  }

  Future<void> _onResetSeasons(ResetSeasons event, Emitter<SeasonsState> emit) async {
    emit(const SeasonsInitial());
  }
}