import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/get_ticket_order_usecase.dart';
import 'get_ticket_order_event.dart';
import 'get_ticket_order_state.dart';

class GetTicketOrderBloc
    extends Bloc<GetTicketOrderBaseEvent, GetTicketOrderState> {
  GetTicketOrderBloc({required GetTicketOrderUseCase getTicketOrderUseCase})
      : _getTicketOrderUseCase = getTicketOrderUseCase,
        super(GetTicketOrderInitialState()) {
    on<GetTicketOrderEvent>(_handleGetTicketOrderEvent);
  }
  final GetTicketOrderUseCase _getTicketOrderUseCase;

  Future<void> _handleGetTicketOrderEvent(
      GetTicketOrderEvent event, Emitter<GetTicketOrderState> emit) async {
    emit(GetTicketOrderLoadingState());
    final result = await _getTicketOrderUseCase(event.ticketOrderId);
    result.fold(
      (failure) => emit(GetTicketOrderFailedState(failure)),
      (success) => emit(GetTicketOrderSuccessState(success)),
    );
  }
}