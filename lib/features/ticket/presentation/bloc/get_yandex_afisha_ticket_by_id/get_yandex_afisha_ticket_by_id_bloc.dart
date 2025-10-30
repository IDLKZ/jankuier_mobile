import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_yandex_afisha_ticket_by_id_usecase.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/get_yandex_afisha_ticket_by_id/get_yandex_afisha_ticket_by_id_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/get_yandex_afisha_ticket_by_id/get_yandex_afisha_ticket_by_id_state.dart';

class GetYandexAfishaTicketByIdBloc extends Bloc<GetYandexAfishaTicketByIdBaseEvent, GetYandexAfishaTicketByIdState> {
  GetYandexAfishaTicketByIdUseCase getYandexAfishaTicketByIdUseCase;

  GetYandexAfishaTicketByIdBloc({required this.getYandexAfishaTicketByIdUseCase})
      : super(GetYandexAfishaTicketByIdInitialState()) {
    on<GetYandexAfishaTicketByIdEvent>(_onGetTicketById);
  }

  Future<void> _onGetTicketById(
    GetYandexAfishaTicketByIdEvent event,
    Emitter<GetYandexAfishaTicketByIdState> emit,
  ) async {
    try {
      print('🎫 GetYandexAfishaTicketByIdBloc: Starting to fetch ticket with ID: ${event.yandexAfishaId}');

      emit(GetYandexAfishaTicketByIdLoadingState());

      final result = await getYandexAfishaTicketByIdUseCase.call(event.yandexAfishaId);

      result.fold(
        (failure) {
          print('❌ GetYandexAfishaTicketByIdBloc: Failed to fetch ticket - ${failure.message}');
          emit(GetYandexAfishaTicketByIdFailedState(failure));
        },
        (ticket) {
          print('✅ GetYandexAfishaTicketByIdBloc: Successfully fetched ticket with ID: ${ticket.id}');
          emit(GetYandexAfishaTicketByIdLoadedState(ticket));
          print('✅ GetYandexAfishaTicketByIdBloc: State emitted successfully');
        },
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in GetYandexAfishaTicketByIdBloc: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
