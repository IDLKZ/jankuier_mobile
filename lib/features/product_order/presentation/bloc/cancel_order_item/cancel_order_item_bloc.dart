import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/cancel_order_item_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_order_item/cancel_order_item_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_order_item/cancel_order_item_state.dart';

@injectable
class CancelOrderItemBloc
    extends Bloc<CancelOrderItemEvent, CancelOrderItemState> {
  final CancelOrderItemUseCase _useCase;

  CancelOrderItemBloc(this._useCase) : super(const CancelOrderItemInitial()) {
    on<CancelItemRequested>(_onCancelItemRequested);
  }

  Future<void> _onCancelItemRequested(
    CancelItemRequested event,
    Emitter<CancelOrderItemState> emit,
  ) async {
    emit(const CancelOrderItemLoading());

    final result = await _useCase(event.productOrderItemId);

    result.fold(
      (failure) => emit(CancelOrderItemError(failure.message ?? "-")),
      (item) => emit(CancelOrderItemSuccess(item)),
    );
  }
}
