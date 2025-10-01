import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_order_by_id_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_state.dart';

@injectable
class GetMyProductOrderByIdBloc
    extends Bloc<GetMyProductOrderByIdEvent, GetMyProductOrderByIdState> {
  final GetMyProductOrderByIdUseCase _useCase;

  GetMyProductOrderByIdBloc(this._useCase)
      : super(const GetMyProductOrderByIdInitial()) {
    on<LoadMyProductOrderById>(_onLoadMyProductOrderById);
  }

  Future<void> _onLoadMyProductOrderById(
    LoadMyProductOrderById event,
    Emitter<GetMyProductOrderByIdState> emit,
  ) async {
    emit(const GetMyProductOrderByIdLoading());

    final result = await _useCase(event.productOrderId);

    result.fold(
      (failure) => emit(GetMyProductOrderByIdError(failure.message ?? "-")),
      (order) => emit(GetMyProductOrderByIdLoaded(order)),
    );
  }
}
