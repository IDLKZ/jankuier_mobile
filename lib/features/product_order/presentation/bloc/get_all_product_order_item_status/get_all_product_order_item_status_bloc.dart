import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_all_product_order_item_status_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_item_status/get_all_product_order_item_status_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_item_status/get_all_product_order_item_status_state.dart';

@injectable
class GetAllProductOrderItemStatusBloc extends Bloc<
    GetAllProductOrderItemStatusEvent, GetAllProductOrderItemStatusState> {
  final GetAllProductOrderItemStatusUseCase _useCase;

  GetAllProductOrderItemStatusBloc(this._useCase)
      : super(const GetAllProductOrderItemStatusInitial()) {
    on<LoadAllProductOrderItemStatus>(_onLoadAllProductOrderItemStatus);
  }

  Future<void> _onLoadAllProductOrderItemStatus(
    LoadAllProductOrderItemStatus event,
    Emitter<GetAllProductOrderItemStatusState> emit,
  ) async {
    emit(const GetAllProductOrderItemStatusLoading());

    final result = await _useCase(event.parameter);

    result.fold(
      (failure) =>
          emit(GetAllProductOrderItemStatusError(failure.message ?? "-")),
      (statuses) => emit(GetAllProductOrderItemStatusLoaded(statuses)),
    );
  }
}
