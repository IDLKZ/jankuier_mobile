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
    on<FilterProductEvent>(_onFilterProducts);
  }

  Future<void> _onPaginateProducts(
    PaginateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    // If this is page 1, we're starting fresh (new filters or initial load)
    final isFirstPage = (event.parameter.page ?? 1) == 1;

    if (state is! PaginateProductLoadedState || isFirstPage) {
      emit(PaginateProductLoadingState());
    }

    final currentProducts = state is PaginateProductLoadedState && !isFirstPage
        ? (state as PaginateProductLoadedState).products
        : <ProductEntity>[];

    final result = await this.paginateProductCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateProductFailedState(failure)),
      (data) {
        final updatedProducts = isFirstPage
            ? data.items // Replace products on first page
            : [...currentProducts, ...data.items]; // Append for subsequent pages
        emit(PaginateProductLoadedState(data, updatedProducts));
      },
    );
  }

  Future<void> _onFilterProducts(
    FilterProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Always show loading when filtering
    emit(PaginateProductLoadingState());

    final result = await this.paginateProductCase.call(event.parameter);

    result.fold(
      (failure) => emit(PaginateProductFailedState(failure)),
      (data) {
        // Always replace products when filtering
        emit(PaginateProductLoadedState(data, data.items));
      },
    );
  }
}
