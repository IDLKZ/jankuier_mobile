import 'package:bloc/bloc.dart';
import '../../domain/use_cases/get_countries_from_sota_case.dart';
import 'get_country_event.dart';
import 'get_country_state.dart';

class GetCountryBloc extends Bloc<GetCountryBaseEvent, GetCountryStateState> {
  GetCountryBloc({required GetCountriesFromSotaCase getCountriesFromSotaCase})
      : _getCountriesFromSotaCase = getCountriesFromSotaCase,
        super(GetCountryStateInitialState()) {
    on<GetCountryEvent>(_handleGetCountryEvent);
  }
  final GetCountriesFromSotaCase _getCountriesFromSotaCase;

  Future<void> _handleGetCountryEvent(
      GetCountryEvent event, Emitter<GetCountryStateState> state) async {
    final result = await _getCountriesFromSotaCase(event.parameter);
    result.fold((failure) => emit(GetCountryStateFailedState(failure)),
        (success) => emit(GetCountryStateSuccessState(success)));
  }
}
