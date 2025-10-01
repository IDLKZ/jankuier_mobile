import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_orders_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_orders/get_my_product_orders_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_orders/get_my_product_orders_state.dart';

@injectable
class GetMyProductOrdersBloc
    extends Bloc<GetMyProductOrdersEvent, GetMyProductOrdersState> {
  final GetMyProductOrdersUseCase _useCase;

  GetMyProductOrdersBloc(this._useCase)
      : super(const GetMyProductOrdersInitial()) {
    on<LoadMyProductOrders>(_onLoadMyProductOrders);
  }

  Future<void> _onLoadMyProductOrders(
    LoadMyProductOrders event,
    Emitter<GetMyProductOrdersState> emit,
  ) async {
    emit(const GetMyProductOrdersLoading());

    final result = await _useCase(event.parameter);

    result.fold(
      (failure) => emit(GetMyProductOrdersError(failure.message ?? "-")),
      (orders) => emit(GetMyProductOrdersLoaded(orders)),
    );
  }
}
