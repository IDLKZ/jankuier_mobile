import 'package:bloc/bloc.dart';
import '../../../../core/common/entities/sota_pagination_entity.dart';
import '../../../../core/constants/sota_api_constants.dart';
import '../../data/entities/country_entity.dart';
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
    result.fold(
      (failure) => emit(GetCountryStateFailedState(failure)),
      (success) {
        // Sort countries to put country with KZCountryId (associated with TournamentId=7) first
        final sortedCountries = _sortCountries(success);
        emit(GetCountryStateSuccessState(sortedCountries));
      },
    );
  }

  SotaPaginationResponse<CountryEntity> _sortCountries(
      SotaPaginationResponse<CountryEntity> response) {
    final countries = List<CountryEntity>.from(response.results);

    // Find index of country with id matching KZCountryId (tournament id=7)
    final kzIndex = countries.indexWhere(
        (country) => country.id == SotaApiConstant.KZCountryId);

    if (kzIndex != -1) {
      // Move KZ country to the first position
      final kzCountry = countries.removeAt(kzIndex);
      countries.insert(0, kzCountry);
    }

    return SotaPaginationResponse(
      count: response.count,
      next: response.next,
      previous: response.previous,
      results: countries,
    );
  }
}
