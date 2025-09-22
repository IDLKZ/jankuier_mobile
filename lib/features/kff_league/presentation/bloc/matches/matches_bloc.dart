import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_match_by_id_usecase.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_matches_usecase.dart';
import '../../../data/entities/kff_league_match_entity.dart';
import '../../../data/entities/kff_league_pagination_response_entity.dart';
import 'matches_event.dart';
import 'matches_state.dart';

@injectable
class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final GetMatchesUseCase _getMatchesUseCase;
  final GetMatchByIdUseCase _getMatchByIdUseCase;

  MatchesBloc(this._getMatchesUseCase, this._getMatchByIdUseCase)
      : super(const MatchesInitial()) {
    on<LoadMatches>(_onLoadMatches);
    on<LoadMatchById>(_onLoadMatchById);
    on<RefreshMatches>(_onRefreshMatches);
    on<ResetMatches>(_onResetMatches);
    on<LoadMoreMatches>(_onLoadMoreMatches);
  }

  Future<void> _onLoadMatches(
      LoadMatches event, Emitter<MatchesState> emit) async {
    emit(const MatchesLoading());

    final result = await _getMatchesUseCase(event.parameter);

    result.fold(
      (failure) => emit(MatchesError(failure.message ?? 'Unknown error')),
      (matches) => emit(MatchesLoaded(matches)),
    );
  }

  Future<void> _onLoadMatchById(
      LoadMatchById event, Emitter<MatchesState> emit) async {
    emit(const MatchesLoading());

    final result = await _getMatchByIdUseCase(event.matchId);

    result.fold(
      (failure) => emit(MatchesError(failure.message ?? 'Unknown error')),
      (match) => emit(SingleMatchLoaded(match)),
    );
  }

  Future<void> _onRefreshMatches(
      RefreshMatches event, Emitter<MatchesState> emit) async {
    final result = await _getMatchesUseCase(event.parameter);

    result.fold(
      (failure) => emit(MatchesError(failure.message ?? 'Unknown error')),
      (matches) => emit(MatchesLoaded(matches)),
    );
  }

  Future<void> _onResetMatches(
      ResetMatches event, Emitter<MatchesState> emit) async {
    emit(const MatchesInitial());
  }

  Future<void> _onLoadMoreMatches(
      LoadMoreMatches event, Emitter<MatchesState> emit) async {
    final currentState = state;
    if (currentState is MatchesLoaded) {
      // Check if there are more pages to load
      if (currentState.matches.meta?.hasNext != true) {
        return; // No more pages to load
      }

      emit(MatchesLoadingMore(currentState.matches));

      final result = await _getMatchesUseCase(event.parameter);

      result.fold(
        (failure) => emit(MatchesError(failure.message ?? 'Unknown error')),
        (newMatches) {
          // Combine current matches with new matches
          final combinedData = [
            ...currentState.matches.data,
            ...newMatches.data,
          ];

          final updatedMatches =
              KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>(
            data: combinedData,
            meta: newMatches.meta,
            success: newMatches.success,
            code: newMatches.code,
          );

          emit(MatchesLoaded(updatedMatches));
        },
      );
    }
  }
}
