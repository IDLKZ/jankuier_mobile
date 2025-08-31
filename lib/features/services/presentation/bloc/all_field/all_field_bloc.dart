import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/all_field_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field/all_field_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field/all_field_state.dart';

class AllFieldBloc extends Bloc<AllFieldEvent, AllFieldState> {
  AllFieldCase allFieldCase;
  AllFieldBloc({required this.allFieldCase})
      : super(AllFieldInitialState()) {
    on<GetAllFieldEvent>(_onAllField);
  }

  Future<void> _onAllField(
    GetAllFieldEvent event,
    Emitter<AllFieldState> emit,
  ) async {
    emit(AllFieldLoadingState());
    final result = await this.allFieldCase.call(event.parameter);
    result.fold(
      (failure) => emit(AllFieldFailedState(failure)),
      (data) {
        emit(AllFieldLoadedState(data));
      },
    );
  }
}