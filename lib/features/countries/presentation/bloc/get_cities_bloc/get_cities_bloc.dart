import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_cities_case.dart';
import 'get_cities_event.dart';
import 'get_cities_state.dart';

class GetCitiesBloc extends Bloc<GetCitiesBaseEvent, GetCitiesState> {
  GetCitiesBloc({required GetCitiesCase getCitiesCase})
      : _getCitiesCase = getCitiesCase,
        super(GetCitiesInitialState()) {
    on<GetCitiesEvent>(_handleGetCitiesEvent);
  }
  final GetCitiesCase _getCitiesCase;

  Future<void> _handleGetCitiesEvent(
      GetCitiesEvent event, Emitter<GetCitiesState> emit) async {
    emit(GetCitiesLoadingState());
    final result = await _getCitiesCase(event.parameter);
    result.fold(
      (failure) => emit(GetCitiesFailedState(failure)),
      (success) => emit(GetCitiesSuccessState(success)),
    );
  }
}