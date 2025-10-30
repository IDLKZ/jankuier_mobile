import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_all_yandex_afisha_tickets_usecase.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/get_all_yandex_afisha_tickets/get_all_yandex_afisha_tickets_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/get_all_yandex_afisha_tickets/get_all_yandex_afisha_tickets_state.dart';

class GetAllYandexAfishaTicketsBloc extends Bloc<GetAllYandexAfishaTicketsBaseEvent, GetAllYandexAfishaTicketsState> {
  GetAllYandexAfishaTicketsUseCase getAllYandexAfishaTicketsUseCase;

  GetAllYandexAfishaTicketsBloc({required this.getAllYandexAfishaTicketsUseCase})
      : super(GetAllYandexAfishaTicketsInitialState()) {
    on<GetAllYandexAfishaTicketsEvent>(_onGetAllTickets);
  }

  Future<void> _onGetAllTickets(
    GetAllYandexAfishaTicketsEvent event,
    Emitter<GetAllYandexAfishaTicketsState> emit,
  ) async {
    try {
      print('🎫 GetAllYandexAfishaTicketsBloc: Starting to fetch all tickets');

      emit(GetAllYandexAfishaTicketsLoadingState());

      final result = await getAllYandexAfishaTicketsUseCase.call(event.parameter);

      result.fold(
        (failure) {
          print('❌ GetAllYandexAfishaTicketsBloc: Failed to fetch tickets - ${failure.message}');
          emit(GetAllYandexAfishaTicketsFailedState(failure));
        },
        (tickets) {
          print('✅ GetAllYandexAfishaTicketsBloc: Received ${tickets.length} tickets');
          emit(GetAllYandexAfishaTicketsLoadedState(tickets));
          print('✅ GetAllYandexAfishaTicketsBloc: State emitted successfully');
        },
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in GetAllYandexAfishaTicketsBloc: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
