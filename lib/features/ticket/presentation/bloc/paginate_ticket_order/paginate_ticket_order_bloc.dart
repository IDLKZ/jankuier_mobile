import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/paginate_ticket_order/paginate_ticket_order_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/paginate_ticket_order/paginate_ticket_order_state.dart';
import '../../../data/entities/ticket_order/ticket_order_entity.dart';

class PaginateTicketOrderBloc extends Bloc<PaginateTicketOrderBaseEvent, PaginateTicketOrderState> {
  PaginateTicketOrderUseCase paginateTicketOrderUseCase;
  PaginateTicketOrderBloc({required this.paginateTicketOrderUseCase})
      : super(PaginateTicketOrderInitialState()) {
    on<PaginateTicketOrderEvent>(_onPaginateTicketOrders);
    on<RefreshTicketOrderEvent>(_onRefreshTicketOrders);
  }

  Future<void> _onPaginateTicketOrders(
    PaginateTicketOrderEvent event,
    Emitter<PaginateTicketOrderState> emit,
  ) async {
    try {
      print('🎫 PaginateTicketOrderBloc: Starting to paginate ticket orders');

      if (state is! PaginateTicketOrderLoadedState) {
        emit(PaginateTicketOrderLoadingState());
      }

      final currentOrders = state is PaginateTicketOrderLoadedState
          ? (state as PaginateTicketOrderLoadedState).orders
          : <TicketonOrderEntity>[];

      print('🎫 Current orders count: ${currentOrders.length}');

      final result = await this.paginateTicketOrderUseCase.call(event.parameter);

      result.fold(
        (failure) {
          print('❌ PaginateTicketOrderBloc: Failed to fetch orders - ${failure.message}');
          emit(PaginateTicketOrderFailedState(failure));
        },
        (data) {
          try {
            print('✅ PaginateTicketOrderBloc: Received ${data.items.length} new orders');
            final updatedOrders = [...currentOrders, ...data.items];
            print('🎫 Total orders after update: ${updatedOrders.length}');
            emit(PaginateTicketOrderLoadedState(data, updatedOrders));
            print('✅ PaginateTicketOrderBloc: State emitted successfully');
          } catch (e, stackTrace) {
            print('❌ PaginateTicketOrderBloc: Error processing orders: $e');
            print('📚 Stack trace: $stackTrace');
            print('🔍 Data items count: ${data.items.length}');
            rethrow;
          }
        },
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in PaginateTicketOrderBloc: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _onRefreshTicketOrders(
    RefreshTicketOrderEvent event,
    Emitter<PaginateTicketOrderState> emit,
  ) async {
    try {
      print('🔄 PaginateTicketOrderBloc: Refreshing ticket orders');

      emit(PaginateTicketOrderLoadingState());

      final result = await paginateTicketOrderUseCase.call(event.parameter);

      result.fold(
        (failure) {
          print('❌ PaginateTicketOrderBloc: Failed to refresh orders - ${failure.message}');
          emit(PaginateTicketOrderFailedState(failure));
        },
        (data) {
          print('✅ PaginateTicketOrderBloc: Refreshed with ${data.items.length} orders');
          // Для refresh не накапливаем старые данные, а заменяем полностью
          emit(PaginateTicketOrderLoadedState(data, data.items));
        },
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in refresh PaginateTicketOrderBloc: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }
}