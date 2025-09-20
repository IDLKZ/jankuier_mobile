import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_one_league_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_one_league/get_one_league_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_one_league/get_one_league_state.dart';

@injectable
class GetOneLeagueBloc extends Bloc<GetOneLeagueEvent, GetOneLeagueState> {
  final GetOneLeagueCase getOneLeagueCase;

  GetOneLeagueBloc({required this.getOneLeagueCase})
      : super(GetOneLeagueInitialState()) {
    on<GetOneLeagueRequestEvent>(_onGetOneLeague);
  }

  Future<void> _onGetOneLeague(
    GetOneLeagueRequestEvent event,
    Emitter<GetOneLeagueState> emit,
  ) async {
    emit(GetOneLeagueLoadingState());

    final result = await getOneLeagueCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetOneLeagueFailedState(failure)),
      (league) => emit(GetOneLeagueSuccessState(league)),
    );
  }
}