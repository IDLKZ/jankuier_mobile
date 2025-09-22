import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournament_by_id_usecase.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournaments_usecase.dart';
import 'tournaments_event.dart';
import 'tournaments_state.dart';

@injectable
class TournamentsBloc extends Bloc<TournamentsEvent, TournamentsState> {
  final GetTournamentsUseCase _getTournamentsUseCase;
  final GetTournamentByIdUseCase _getTournamentByIdUseCase;

  TournamentsBloc(this._getTournamentsUseCase, this._getTournamentByIdUseCase) : super(const TournamentsInitial()) {
    on<LoadTournaments>(_onLoadTournaments);
    on<LoadTournamentById>(_onLoadTournamentById);
    on<RefreshTournaments>(_onRefreshTournaments);
    on<ResetTournaments>(_onResetTournaments);
  }

  Future<void> _onLoadTournaments(LoadTournaments event, Emitter<TournamentsState> emit) async {
    emit(const TournamentsLoading());

    final result = await _getTournamentsUseCase(const NoParams());

    result.fold(
      (failure) => emit(TournamentsError(failure.message ?? 'Unknown error')),
      (tournaments) => emit(TournamentsLoaded(tournaments)),
    );
  }

  Future<void> _onLoadTournamentById(LoadTournamentById event, Emitter<TournamentsState> emit) async {
    emit(const TournamentsLoading());

    final result = await _getTournamentByIdUseCase(event.tournamentId);

    result.fold(
      (failure) => emit(TournamentsError(failure.message ?? 'Unknown error')),
      (tournament) => emit(SingleTournamentLoaded(tournament)),
    );
  }

  Future<void> _onRefreshTournaments(RefreshTournaments event, Emitter<TournamentsState> emit) async {
    final result = await _getTournamentsUseCase(const NoParams());

    result.fold(
      (failure) => emit(TournamentsError(failure.message ?? 'Unknown error')),
      (tournaments) => emit(TournamentsLoaded(tournaments)),
    );
  }

  Future<void> _onResetTournaments(ResetTournaments event, Emitter<TournamentsState> emit) async {
    emit(const TournamentsInitial());
  }
}