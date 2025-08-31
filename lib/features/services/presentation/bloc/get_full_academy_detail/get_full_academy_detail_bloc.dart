import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/academy/get_full_academy_detail_case.dart';
import 'get_full_academy_detail_event.dart';
import 'get_full_academy_detail_state.dart';

class GetFullAcademyDetailBloc extends Bloc<GetFullAcademyDetailEvent, GetFullAcademyDetailState> {
  GetFullAcademyDetailCase getFullAcademyDetailCase;
  GetFullAcademyDetailBloc({required this.getFullAcademyDetailCase})
      : super(GetFullAcademyDetailInitialState()) {
    on<GetFullAcademyEvent>(_getFullAcademyDetailEvent);
  }

  Future<void> _getFullAcademyDetailEvent(
    GetFullAcademyEvent event,
    Emitter<GetFullAcademyDetailState> emit,
  ) async {
    emit(GetFullAcademyDetailLoadingState());
    final result = await this.getFullAcademyDetailCase.call(event.academyId);
    result.fold(
      (failure) => emit(GetFullAcademyDetailFailedState(failure)),
      (data) {
        emit(GetFullAcademyDetailLoadedState(data));
      },
    );
  }
}