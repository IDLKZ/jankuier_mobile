import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/academy/get_academy_group_schedule_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy_group_schedule/academy_group_schedule_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy_group_schedule/academy_group_schedule_state.dart';

class AcademyGroupScheduleBloc extends Bloc<AcademyGroupScheduleEvent, AcademyGroupScheduleState> {
  GetAcademyGroupScheduleCase getAcademyGroupScheduleCase;
  AcademyGroupScheduleBloc({required this.getAcademyGroupScheduleCase})
      : super(AcademyGroupScheduleInitialState()) {
    on<GetAcademyGroupScheduleEvent>(_onGetAcademyGroupSchedule);
  }

  Future<void> _onGetAcademyGroupSchedule(
    GetAcademyGroupScheduleEvent event,
    Emitter<AcademyGroupScheduleState> emit,
  ) async {
    emit(AcademyGroupScheduleLoadingState());
    final result = await this.getAcademyGroupScheduleCase.call(event.parameter);
    result.fold(
      (failure) => emit(AcademyGroupScheduleFailedState(failure)),
      (data) {
        emit(AcademyGroupScheduleLoadedState(data));
      },
    );
  }
}