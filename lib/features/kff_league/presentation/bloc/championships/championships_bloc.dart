import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championship_by_id_usecase.dart';
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championships_usecase.dart';
import 'championships_event.dart';
import 'championships_state.dart';

@injectable
class ChampionshipsBloc extends Bloc<ChampionshipsEvent, ChampionshipsState> {
  final GetChampionshipsUseCase _getChampionshipsUseCase;
  final GetChampionshipByIdUseCase _getChampionshipByIdUseCase;

  ChampionshipsBloc(this._getChampionshipsUseCase, this._getChampionshipByIdUseCase) : super(const ChampionshipsInitial()) {
    on<LoadChampionships>(_onLoadChampionships);
    on<LoadChampionshipById>(_onLoadChampionshipById);
    on<RefreshChampionships>(_onRefreshChampionships);
    on<ResetChampionships>(_onResetChampionships);
  }

  Future<void> _onLoadChampionships(LoadChampionships event, Emitter<ChampionshipsState> emit) async {
    emit(const ChampionshipsLoading());

    final result = await _getChampionshipsUseCase(event.parameter);

    result.fold(
      (failure) => emit(ChampionshipsError(failure.message ?? 'Unknown error')),
      (championships) => emit(ChampionshipsLoaded(championships)),
    );
  }

  Future<void> _onLoadChampionshipById(LoadChampionshipById event, Emitter<ChampionshipsState> emit) async {
    emit(const ChampionshipsLoading());

    final result = await _getChampionshipByIdUseCase(event.championshipId);

    result.fold(
      (failure) => emit(ChampionshipsError(failure.message ?? 'Unknown error')),
      (championship) => emit(SingleChampionshipLoaded(championship)),
    );
  }

  Future<void> _onRefreshChampionships(RefreshChampionships event, Emitter<ChampionshipsState> emit) async {
    final result = await _getChampionshipsUseCase(event.parameter);

    result.fold(
      (failure) => emit(ChampionshipsError(failure.message ?? 'Unknown error')),
      (championships) => emit(ChampionshipsLoaded(championships)),
    );
  }

  Future<void> _onResetChampionships(ResetChampionships event, Emitter<ChampionshipsState> emit) async {
    emit(const ChampionshipsInitial());
  }
}