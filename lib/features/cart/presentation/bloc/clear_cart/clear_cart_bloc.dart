import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_state.dart';

@injectable
class ClearCartBloc extends Bloc<ClearCartEvent, ClearCartState> {
  final ClearCartUseCase _clearCartUseCase;

  ClearCartBloc(this._clearCartUseCase) : super(const ClearCartInitial()) {
    on<ClearCartRequested>(_onClearCartRequested);
  }

  Future<void> _onClearCartRequested(
    ClearCartRequested event,
    Emitter<ClearCartState> emit,
  ) async {
    emit(const ClearCartLoading());

    final result = await _clearCartUseCase(event.cartId);

    result.fold(
      (failure) => emit(ClearCartError(failure.message ?? "-")),
      (response) => emit(ClearCartSuccess(response)),
    );
  }
}
