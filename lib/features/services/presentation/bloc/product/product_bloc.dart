import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/product/paginate_product_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';
import '../../../data/entities/product/product_entity.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  PaginateProductCase paginateProductCase;
  ProductBloc({required this.paginateProductCase})
      : super(ProductInitialState()) {
    on<PaginateProductEvent>(_onPaginateProducts);
  }

  Future<void> _onPaginateProducts(
    PaginateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! PaginateProductLoadedState) {
      emit(PaginateProductLoadingState());
    }

    final currentProducts = state is PaginateProductLoadedState
        ? (state as PaginateProductLoadedState).products
        : <ProductEntity>[];
    final result = await this.paginateProductCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateProductFailedState(failure)),
      (data) {
        final updatedProducts = [...currentProducts, ...data.items];
        emit(PaginateProductLoadedState(data, updatedProducts));
      },
    );
  }
}
