import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/academy/paginate_academy_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_state.dart';
import '../../../data/entities/academy/academy_entity.dart';

class AcademyBloc extends Bloc<AcademyEvent, AcademyState> {
  PaginateAcademyCase paginateAcademyCase;
  AcademyBloc({required this.paginateAcademyCase})
      : super(AcademyInitialState()) {
    on<PaginateAcademyEvent>(_onPaginateAcademies);
  }

  Future<void> _onPaginateAcademies(
    PaginateAcademyEvent event,
    Emitter<AcademyState> emit,
  ) async {
    if (state is! PaginateAcademyLoadedState) {
      emit(PaginateAcademyLoadingState());
    }

    final currentAcademies = state is PaginateAcademyLoadedState
        ? (state as PaginateAcademyLoadedState).academies
        : <AcademyEntity>[];
    final result = await this.paginateAcademyCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateAcademyFailedState(failure)),
      (data) {
        final updatedAcademies = [...currentAcademies, ...data.items];
        emit(PaginateAcademyLoadedState(data, updatedAcademies));
      },
    );
  }
}