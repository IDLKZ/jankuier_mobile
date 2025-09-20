import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/paginate_field_party_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_state.dart';
import '../../../data/entities/field/field_party_entity.dart';

class FieldPartyBloc extends Bloc<FieldPartyEvent, FieldPartyState> {
  PaginateFieldPartyCase paginateFieldPartyCase;
  FieldPartyBloc({required this.paginateFieldPartyCase})
      : super(FieldPartyInitialState()) {
    on<PaginateFieldPartyEvent>(_onPaginateFieldParties);
  }

  Future<void> _onPaginateFieldParties(
    PaginateFieldPartyEvent event,
    Emitter<FieldPartyState> emit,
  ) async {
    // If this is page 1, we're starting fresh (new filters or initial load)
    final isFirstPage = (event.parameter.page ?? 1) == 1;

    if (state is! PaginateFieldPartyLoadedState || isFirstPage) {
      emit(PaginateFieldPartyLoadingState());
    }

    final currentFieldParties = state is PaginateFieldPartyLoadedState && !isFirstPage
        ? (state as PaginateFieldPartyLoadedState).fieldParties
        : <FieldPartyEntity>[];

    final result = await this.paginateFieldPartyCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateFieldPartyFailedState(failure)),
      (data) {
        final updatedFieldParties = isFirstPage
            ? data.items // Replace field parties on first page
            : [...currentFieldParties, ...data.items]; // Append for subsequent pages
        emit(PaginateFieldPartyLoadedState(data, updatedFieldParties));
      },
    );
  }
}