import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_players_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_players/get_players_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_players/get_players_state.dart';

@injectable
class GetPlayersBloc extends Bloc<GetPlayersEvent, GetPlayersState> {
  final GetPlayersCase getPlayersCase;

  GetPlayersBloc({required this.getPlayersCase})
      : super(GetPlayersInitialState()) {
    on<GetPlayersRequestEvent>(_onGetPlayers);
  }

  Future<void> _onGetPlayers(
    GetPlayersRequestEvent event,
    Emitter<GetPlayersState> emit,
  ) async {
    emit(GetPlayersLoadingState());

    final result = await getPlayersCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetPlayersFailedState(failure)),
      (players) => emit(GetPlayersSuccessState(players)),
    );
  }
}