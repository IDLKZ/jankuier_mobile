import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/create_product_order_from_cart_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_state.dart';

@injectable
class CreateProductOrderFromCartBloc extends Bloc<
    CreateProductOrderFromCartEvent, CreateProductOrderFromCartState> {
  final CreateProductOrderFromCartUseCase _useCase;

  CreateProductOrderFromCartBloc(this._useCase)
      : super(const CreateProductOrderFromCartInitial()) {
    on<CreateOrderFromCart>(_onCreateOrderFromCart);
  }

  Future<void> _onCreateOrderFromCart(
    CreateOrderFromCart event,
    Emitter<CreateProductOrderFromCartState> emit,
  ) async {
    emit(const CreateProductOrderFromCartLoading());

    final result = await _useCase(
        CreateProductOrderParams(phone: event.phone, email: event.email));

    result.fold(
      (failure) =>
          emit(CreateProductOrderFromCartError(failure.message ?? "-")),
      (response) => emit(CreateProductOrderFromCartSuccess(response)),
    );
  }
}
