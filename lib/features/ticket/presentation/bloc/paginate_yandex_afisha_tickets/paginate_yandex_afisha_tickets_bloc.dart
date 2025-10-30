import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_yandex_afisha_tickets_usecase.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/paginate_yandex_afisha_tickets/paginate_yandex_afisha_tickets_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/paginate_yandex_afisha_tickets/paginate_yandex_afisha_tickets_state.dart';
import '../../../data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';

class PaginateYandexAfishaTicketsBloc extends Bloc<PaginateYandexAfishaTicketsBaseEvent, PaginateYandexAfishaTicketsState> {
  PaginateYandexAfishaTicketsUseCase paginateYandexAfishaTicketsUseCase;

  PaginateYandexAfishaTicketsBloc({required this.paginateYandexAfishaTicketsUseCase})
      : super(PaginateYandexAfishaTicketsInitialState()) {
    on<PaginateYandexAfishaTicketsEvent>(_onPaginateTickets);
    on<RefreshYandexAfishaTicketsEvent>(_onRefreshTickets);
  }

  Future<void> _onPaginateTickets(
    PaginateYandexAfishaTicketsEvent event,
    Emitter<PaginateYandexAfishaTicketsState> emit,
  ) async {
    try {
      print('🎫 PaginateYandexAfishaTicketsBloc: Starting to paginate tickets');

      if (state is! PaginateYandexAfishaTicketsLoadedState) {
        emit(PaginateYandexAfishaTicketsLoadingState());
      }

      final currentTickets = state is PaginateYandexAfishaTicketsLoadedState
          ? (state as PaginateYandexAfishaTicketsLoadedState).tickets
          : <YandexAfishaWidgetTicketEntity>[];

      print('🎫 Current tickets count: ${currentTickets.length}');

      final result = await paginateYandexAfishaTicketsUseCase.call(event.parameter);

      result.fold(
        (failure) {
          print('❌ PaginateYandexAfishaTicketsBloc: Failed to fetch tickets - ${failure.message}');
          emit(PaginateYandexAfishaTicketsFailedState(failure));
        },
        (data) {
          try {
            print('✅ PaginateYandexAfishaTicketsBloc: Received ${data.items.length} new tickets');
            final updatedTickets = [...currentTickets, ...data.items];
            print('🎫 Total tickets after update: ${updatedTickets.length}');
            emit(PaginateYandexAfishaTicketsLoadedState(data, updatedTickets));
            print('✅ PaginateYandexAfishaTicketsBloc: State emitted successfully');
          } catch (e, stackTrace) {
            print('❌ PaginateYandexAfishaTicketsBloc: Error processing tickets: $e');
            print('📚 Stack trace: $stackTrace');
            print('🔍 Data items count: ${data.items.length}');
            rethrow;
          }
        },
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in PaginateYandexAfishaTicketsBloc: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _onRefreshTickets(
    RefreshYandexAfishaTicketsEvent event,
    Emitter<PaginateYandexAfishaTicketsState> emit,
  ) async {
    try {
      print('🔄 PaginateYandexAfishaTicketsBloc: Refreshing tickets');

      emit(PaginateYandexAfishaTicketsLoadingState());

      final result = await paginateYandexAfishaTicketsUseCase.call(event.parameter);

      result.fold(
        (failure) {
          print('❌ PaginateYandexAfishaTicketsBloc: Failed to refresh tickets - ${failure.message}');
          emit(PaginateYandexAfishaTicketsFailedState(failure));
        },
        (data) {
          print('✅ PaginateYandexAfishaTicketsBloc: Refreshed with ${data.items.length} tickets');
          // Для refresh не накапливаем старые данные, а заменяем полностью
          emit(PaginateYandexAfishaTicketsLoadedState(data, data.items));
        },
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in refresh PaginateYandexAfishaTicketsBloc: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
