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
    if (state is! PaginateFieldPartyLoadedState) {
      emit(PaginateFieldPartyLoadingState());
    }

    final currentFieldParties = state is PaginateFieldPartyLoadedState
        ? (state as PaginateFieldPartyLoadedState).fieldParties
        : <FieldPartyEntity>[];
    final result = await this.paginateFieldPartyCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateFieldPartyFailedState(failure)),
      (data) {
        final updatedFieldParties = [...currentFieldParties, ...data.items];
        emit(PaginateFieldPartyLoadedState(data, updatedFieldParties));
      },
    );
  }
}