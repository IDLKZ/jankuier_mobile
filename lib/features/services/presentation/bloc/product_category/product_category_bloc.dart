import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_state.dart';
import '../../../domain/use_cases/product/all_product_category_case.dart';

class AllProductCategoryBloc
    extends Bloc<AllProductCategoryEvent, AllProductCategoryState> {
  AllProductCategoryCase allProductCategoryCase;
  AllProductCategoryBloc({required this.allProductCategoryCase})
      : super(AllProductCategoryInitialState()) {
    on<GetAllProductCategoryEvent>(_onAllProductCategory);
  }

  Future<void> _onAllProductCategory(
    GetAllProductCategoryEvent event,
    Emitter<AllProductCategoryState> emit,
  ) async {
    emit(AllProductCategoryLoadingState());
    final result = await this.allProductCategoryCase.call(event.parameter);
    result.fold(
      (failure) => emit(AllProductCategoryFailedState(failure)),
      (data) {
        emit(AllProductCategoryLoadedState(data));
      },
    );
  }
}
