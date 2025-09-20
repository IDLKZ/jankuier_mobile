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
    // If this is page 1, we're starting fresh (new filters or initial load)
    final isFirstPage = (event.parameter.page ?? 1) == 1;

    if (state is! PaginateAcademyLoadedState || isFirstPage) {
      emit(PaginateAcademyLoadingState());
    }

    final currentAcademies = state is PaginateAcademyLoadedState && !isFirstPage
        ? (state as PaginateAcademyLoadedState).academies
        : <AcademyEntity>[];

    final result = await this.paginateAcademyCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateAcademyFailedState(failure)),
      (data) {
        final updatedAcademies = isFirstPage
            ? data.items // Replace academies on first page
            : [...currentAcademies, ...data.items]; // Append for subsequent pages
        emit(PaginateAcademyLoadedState(data, updatedAcademies));
      },
    );
  }
}