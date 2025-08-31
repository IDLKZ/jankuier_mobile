import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/get_field_party_case.dart';
import 'get_field_party_detail_event.dart';
import 'get_field_party_detail_state.dart';

class GetFieldPartyDetailBloc extends Bloc<GetFieldPartyDetailEvent, GetFieldPartyDetailState> {
  GetFieldPartyCase getFieldPartyCase;
  GetFieldPartyDetailBloc({required this.getFieldPartyCase})
      : super(GetFieldPartyDetailInitialState()) {
    on<GetFieldPartyEvent>(_getFieldPartyDetailEvent);
  }

  Future<void> _getFieldPartyDetailEvent(
    GetFieldPartyEvent event,
    Emitter<GetFieldPartyDetailState> emit,
  ) async {
    emit(GetFieldPartyDetailLoadingState());
    final result = await this.getFieldPartyCase.call(event.fieldPartyId);
    result.fold(
      (failure) => emit(GetFieldPartyDetailFailedState(failure)),
      (data) {
        emit(GetFieldPartyDetailLoadedState(data));
      },
    );
  }
}