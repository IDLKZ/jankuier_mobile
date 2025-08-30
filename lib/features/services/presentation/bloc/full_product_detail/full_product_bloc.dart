import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/product/get_full_product_detail_case.dart';
import 'full_product_detail_state.dart';
import 'full_product_event.dart';

class FullProductBloc extends Bloc<FullProductEvent, GetFullProductState> {
  GetFullProductDetailCase getFullProductDetailCase;
  FullProductBloc({required this.getFullProductDetailCase})
      : super(GetFullProductInitialState()) {
    on<GetFullProductEvent>(_getFullProductDetailEvent);
  }

  Future<void> _getFullProductDetailEvent(
    GetFullProductEvent event,
    Emitter<GetFullProductState> emit,
  ) async {
    emit(GetFullProductLoadingState());
    final result = await this.getFullProductDetailCase.call(event.productId);
    result.fold(
      (failure) => emit(GetFullProductFailedState(failure)),
      (data) {
        emit(GetFullProductLoadedState(data));
      },
    );
  }
}
