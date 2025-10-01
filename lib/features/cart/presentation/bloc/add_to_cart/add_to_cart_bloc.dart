import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_state.dart';

@injectable
class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final AddToCartUseCase _addToCartUseCase;

  AddToCartBloc(this._addToCartUseCase) : super(const AddToCartInitial()) {
    on<AddToCartRequested>(_onAddToCartRequested);
  }

  Future<void> _onAddToCartRequested(
    AddToCartRequested event,
    Emitter<AddToCartState> emit,
  ) async {
    emit(const AddToCartLoading());

    final result = await _addToCartUseCase(event.parameter);

    result.fold(
      (failure) => emit(AddToCartError(failure.message ?? "-")),
      (response) => emit(AddToCartSuccess(response)),
    );
  }
}
