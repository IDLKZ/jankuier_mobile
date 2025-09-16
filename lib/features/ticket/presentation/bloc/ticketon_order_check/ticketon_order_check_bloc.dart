import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/ticketon_order_check_usecase.dart';
import 'ticketon_order_check_event.dart';
import 'ticketon_order_check_state.dart';

class TicketonOrderCheckBloc
    extends Bloc<TicketonOrderCheckBaseEvent, TicketonOrderCheckState> {
  TicketonOrderCheckBloc({required TicketonOrderCheckUseCase ticketonOrderCheckUseCase})
      : _ticketonOrderCheckUseCase = ticketonOrderCheckUseCase,
        super(TicketonOrderCheckInitialState()) {
    on<TicketonOrderCheckEvent>(_handleTicketonOrderCheckEvent);
  }
  final TicketonOrderCheckUseCase _ticketonOrderCheckUseCase;

  Future<void> _handleTicketonOrderCheckEvent(
      TicketonOrderCheckEvent event, Emitter<TicketonOrderCheckState> emit) async {
    emit(TicketonOrderCheckLoadingState());
    final result = await _ticketonOrderCheckUseCase(event.ticketOrderId);
    result.fold(
      (failure) => emit(TicketonOrderCheckFailedState(failure)),
      (success) => emit(TicketonOrderCheckSuccessState(success)),
    );
  }
}