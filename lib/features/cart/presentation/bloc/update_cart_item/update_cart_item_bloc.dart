import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_state.dart';

@injectable
class UpdateCartItemBloc
    extends Bloc<UpdateCartItemEvent, UpdateCartItemState> {
  final UpdateCartItemUseCase _updateCartItemUseCase;

  UpdateCartItemBloc(this._updateCartItemUseCase)
      : super(const UpdateCartItemInitial()) {
    on<UpdateCartItemRequested>(_onUpdateCartItemRequested);
  }

  Future<void> _onUpdateCartItemRequested(
    UpdateCartItemRequested event,
    Emitter<UpdateCartItemState> emit,
  ) async {
    emit(const UpdateCartItemLoading());

    final result = await _updateCartItemUseCase(event.parameter);

    result.fold(
      (failure) => emit(UpdateCartItemError(failure.message ?? "-")),
      (response) => emit(UpdateCartItemSuccess(response)),
    );
  }
}
