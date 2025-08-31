import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/get_field_party_schedule_preview_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party_schedule_preview/field_party_schedule_preview_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party_schedule_preview/field_party_schedule_preview_state.dart';

class FieldPartySchedulePreviewBloc extends Bloc<FieldPartySchedulePreviewEvent, FieldPartySchedulePreviewState> {
  GetFieldPartySchedulePreviewCase getFieldPartySchedulePreviewCase;
  FieldPartySchedulePreviewBloc({required this.getFieldPartySchedulePreviewCase})
      : super(FieldPartySchedulePreviewInitialState()) {
    on<GetFieldPartySchedulePreviewEvent>(_onGetFieldPartySchedulePreview);
  }

  Future<void> _onGetFieldPartySchedulePreview(
    GetFieldPartySchedulePreviewEvent event,
    Emitter<FieldPartySchedulePreviewState> emit,
  ) async {
    emit(FieldPartySchedulePreviewLoadingState());
    final result = await this.getFieldPartySchedulePreviewCase.call(event.parameter);
    result.fold(
      (failure) => emit(FieldPartySchedulePreviewFailedState(failure)),
      (data) {
        emit(FieldPartySchedulePreviewLoadedState(data));
      },
    );
  }
}