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
  }

  Future<void> _onPaginateTicketOrders(
    PaginateTicketOrderEvent event,
    Emitter<PaginateTicketOrderState> emit,
  ) async {
    if (state is! PaginateTicketOrderLoadedState) {
      emit(PaginateTicketOrderLoadingState());
    }

    final currentOrders = state is PaginateTicketOrderLoadedState
        ? (state as PaginateTicketOrderLoadedState).orders
        : <TicketonOrderEntity>[];
    final result = await this.paginateTicketOrderUseCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateTicketOrderFailedState(failure)),
      (data) {
        final updatedOrders = [...currentOrders, ...data.items];
        emit(PaginateTicketOrderLoadedState(data, updatedOrders));
      },
    );
  }
}