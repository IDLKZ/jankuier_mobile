import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/cart/domain/usecases/get_my_cart_usecase.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_state.dart';

@injectable
class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  final GetMyCartUseCase _getMyCartUseCase;

  MyCartBloc(this._getMyCartUseCase) : super(const MyCartInitial()) {
    on<LoadMyCart>(_onLoadMyCart);
  }

  Future<void> _onLoadMyCart(
    LoadMyCart event,
    Emitter<MyCartState> emit,
  ) async {
    emit(const MyCartLoading());

    final result = await _getMyCartUseCase(event.checkCartItems);

    result.fold(
      (failure) => emit(MyCartError(failure.message ?? "-")),
      (response) => emit(MyCartLoaded(response)),
    );
  }
}
