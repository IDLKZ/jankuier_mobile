import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_order_items_by_id_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_items_by_id/get_my_product_order_items_by_id_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_items_by_id/get_my_product_order_items_by_id_state.dart';

@injectable
class GetMyProductOrderItemsByIdBloc extends Bloc<
    GetMyProductOrderItemsByIdEvent, GetMyProductOrderItemsByIdState> {
  final GetMyProductOrderItemsByIdUseCase _useCase;

  GetMyProductOrderItemsByIdBloc(this._useCase)
      : super(const GetMyProductOrderItemsByIdInitial()) {
    on<LoadMyProductOrderItemsById>(_onLoadMyProductOrderItemsById);
  }

  Future<void> _onLoadMyProductOrderItemsById(
    LoadMyProductOrderItemsById event,
    Emitter<GetMyProductOrderItemsByIdState> emit,
  ) async {
    emit(const GetMyProductOrderItemsByIdLoading());

    final result = await _useCase(GetMyProductOrderItemsByIdParams(
        event.productOrderId, event.parameter));

    result.fold(
      (failure) =>
          emit(GetMyProductOrderItemsByIdError(failure.message ?? "-")),
      (items) => emit(GetMyProductOrderItemsByIdLoaded(items)),
    );
  }
}
