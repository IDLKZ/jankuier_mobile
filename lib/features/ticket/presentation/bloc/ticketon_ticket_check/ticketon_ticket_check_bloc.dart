import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/ticketon_ticket_check_usecase.dart';
import 'ticketon_ticket_check_event.dart';
import 'ticketon_ticket_check_state.dart';

class TicketonTicketCheckBloc
    extends Bloc<TicketonTicketCheckBaseEvent, TicketonTicketCheckState> {
  TicketonTicketCheckBloc({required TicketonTicketCheckUseCase ticketonTicketCheckUseCase})
      : _ticketonTicketCheckUseCase = ticketonTicketCheckUseCase,
        super(TicketonTicketCheckInitialState()) {
    on<TicketonTicketCheckEvent>(_handleTicketonTicketCheckEvent);
  }
  final TicketonTicketCheckUseCase _ticketonTicketCheckUseCase;

  Future<void> _handleTicketonTicketCheckEvent(
      TicketonTicketCheckEvent event, Emitter<TicketonTicketCheckState> emit) async {
    emit(TicketonTicketCheckLoadingState());
    final result = await _ticketonTicketCheckUseCase(event.parameter);
    result.fold(
      (failure) => emit(TicketonTicketCheckFailedState(failure)),
      (success) => emit(TicketonTicketCheckSuccessState(success)),
    );
  }
}