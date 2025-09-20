import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_coaches_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_state.dart';

@injectable
class GetCoachesBloc extends Bloc<GetCoachesEvent, GetCoachesState> {
  final GetCoachesCase getCoachesCase;

  GetCoachesBloc({required this.getCoachesCase})
      : super(GetCoachesInitialState()) {
    on<GetCoachesRequestEvent>(_onGetCoaches);
  }

  Future<void> _onGetCoaches(
    GetCoachesRequestEvent event,
    Emitter<GetCoachesState> emit,
  ) async {
    emit(GetCoachesLoadingState());

    final result = await getCoachesCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetCoachesFailedState(failure)),
      (coaches) => emit(GetCoachesSuccessState(coaches)),
    );
  }
}