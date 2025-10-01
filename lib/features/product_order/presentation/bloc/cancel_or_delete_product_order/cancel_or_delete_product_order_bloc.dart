import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/cancel_or_delete_product_order_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_state.dart';

@injectable
class CancelOrDeleteProductOrderBloc extends Bloc<
    CancelOrDeleteProductOrderEvent, CancelOrDeleteProductOrderState> {
  final CancelOrDeleteProductOrderUseCase _useCase;

  CancelOrDeleteProductOrderBloc(this._useCase)
      : super(const CancelOrDeleteProductOrderInitial()) {
    on<CancelOrDeleteOrder>(_onCancelOrDeleteOrder);
  }

  Future<void> _onCancelOrDeleteOrder(
    CancelOrDeleteOrder event,
    Emitter<CancelOrDeleteProductOrderState> emit,
  ) async {
    emit(const CancelOrDeleteProductOrderLoading());

    final result = await _useCase(CancelOrDeleteProductOrderParams(
        event.productOrderId,
        isDelete: event.isDelete));

    result.fold(
      (failure) =>
          emit(CancelOrDeleteProductOrderError(failure.message ?? "-")),
      (success) => emit(CancelOrDeleteProductOrderSuccess(success)),
    );
  }
}
