import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_all_league_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_state.dart';

@injectable
class GetAllLeagueBloc extends Bloc<GetAllLeagueEvent, GetAllLeagueState> {
  final GetAllLeagueCase getAllLeagueCase;

  GetAllLeagueBloc({required this.getAllLeagueCase})
      : super(GetAllLeagueInitialState()) {
    on<GetAllLeagueRequestEvent>(_onGetAllLeague);
  }

  Future<void> _onGetAllLeague(
    GetAllLeagueRequestEvent event,
    Emitter<GetAllLeagueState> emit,
  ) async {
    emit(GetAllLeagueLoadingState());

    final result = await getAllLeagueCase.call();

    result.fold(
      (failure) => emit(GetAllLeagueFailedState(failure)),
      (leagues) => emit(GetAllLeagueSuccessState(leagues)),
    );
  }
}