import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/get_field_case.dart';
import 'get_field_detail_event.dart';
import 'get_field_detail_state.dart';

class GetFieldDetailBloc extends Bloc<GetFieldDetailEvent, GetFieldDetailState> {
  GetFieldCase getFieldCase;
  GetFieldDetailBloc({required this.getFieldCase})
      : super(GetFieldDetailInitialState()) {
    on<GetFieldEvent>(_getFieldDetailEvent);
  }

  Future<void> _getFieldDetailEvent(
    GetFieldEvent event,
    Emitter<GetFieldDetailState> emit,
  ) async {
    emit(GetFieldDetailLoadingState());
    final result = await this.getFieldCase.call(event.fieldId);
    result.fold(
      (failure) => emit(GetFieldDetailFailedState(failure)),
      (data) {
        emit(GetFieldDetailLoadedState(data));
      },
    );
  }
}