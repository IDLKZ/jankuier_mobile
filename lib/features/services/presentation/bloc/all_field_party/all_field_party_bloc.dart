import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/all_field_party_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field_party/all_field_party_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field_party/all_field_party_state.dart';

class AllFieldPartyBloc extends Bloc<AllFieldPartyEvent, AllFieldPartyState> {
  AllFieldPartyCase allFieldPartyCase;
  AllFieldPartyBloc({required this.allFieldPartyCase})
      : super(AllFieldPartyInitialState()) {
    on<GetAllFieldPartyEvent>(_onAllFieldParty);
  }

  Future<void> _onAllFieldParty(
    GetAllFieldPartyEvent event,
    Emitter<AllFieldPartyState> emit,
  ) async {
    emit(AllFieldPartyLoadingState());
    final result = await this.allFieldPartyCase.call(event.parameter);
    result.fold(
      (failure) => emit(AllFieldPartyFailedState(failure)),
      (data) {
        emit(AllFieldPartyLoadedState(data));
      },
    );
  }
}