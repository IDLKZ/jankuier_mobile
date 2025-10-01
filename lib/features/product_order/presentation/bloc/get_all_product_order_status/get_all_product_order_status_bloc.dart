import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_all_product_order_status_usecase.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_status/get_all_product_order_status_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_status/get_all_product_order_status_state.dart';

@injectable
class GetAllProductOrderStatusBloc
    extends Bloc<GetAllProductOrderStatusEvent, GetAllProductOrderStatusState> {
  final GetAllProductOrderStatusUseCase _useCase;

  GetAllProductOrderStatusBloc(this._useCase)
      : super(const GetAllProductOrderStatusInitial()) {
    on<LoadAllProductOrderStatus>(_onLoadAllProductOrderStatus);
  }

  Future<void> _onLoadAllProductOrderStatus(
    LoadAllProductOrderStatus event,
    Emitter<GetAllProductOrderStatusState> emit,
  ) async {
    emit(const GetAllProductOrderStatusLoading());

    final result = await _useCase(event.parameter);

    result.fold(
      (failure) => emit(GetAllProductOrderStatusError(failure.message ?? "-")),
      (statuses) => emit(GetAllProductOrderStatusLoaded(statuses)),
    );
  }
}
