import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/paginate_field_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field/field_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field/field_state.dart';
import '../../../data/entities/field/field_entity.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  PaginateFieldCase paginateFieldCase;
  FieldBloc({required this.paginateFieldCase})
      : super(FieldInitialState()) {
    on<PaginateFieldEvent>(_onPaginateFields);
  }

  Future<void> _onPaginateFields(
    PaginateFieldEvent event,
    Emitter<FieldState> emit,
  ) async {
    if (state is! PaginateFieldLoadedState) {
      emit(PaginateFieldLoadingState());
    }

    final currentFields = state is PaginateFieldLoadedState
        ? (state as PaginateFieldLoadedState).fields
        : <FieldEntity>[];
    final result = await this.paginateFieldCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateFieldFailedState(failure)),
      (data) {
        final updatedFields = [...currentFields, ...data.items];
        emit(PaginateFieldLoadedState(data, updatedFields));
      },
    );
  }
}