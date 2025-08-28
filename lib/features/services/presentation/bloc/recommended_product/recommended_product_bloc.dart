import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/product/paginate_product_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/recommended_product/recommended_product_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/recommended_product/recommended_product_state.dart';

class RecommendedProductBloc
    extends Bloc<RecommendedProductEvent, RecommendedProductState> {
  PaginateProductCase paginateProductCase;
  RecommendedProductBloc({required this.paginateProductCase})
      : super(RecommendedProductInitialState()) {
    on<GetRecommendedProductEvent>(_onRecommendedProduct);
  }

  Future<void> _onRecommendedProduct(
    GetRecommendedProductEvent event,
    Emitter<RecommendedProductState> emit,
  ) async {
    emit(RecommendedProductLoadingState());
    final result = await this.paginateProductCase.call(event.parameter);
    result.fold(
      (failure) => emit(RecommendedProductFailedState(failure)),
      (data) {
        emit(RecommendedProductLoadedState(data));
      },
    );
  }
}
