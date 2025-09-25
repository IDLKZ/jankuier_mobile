import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_event.dart';
import 'package:jankuier_mobile/features/services/presentation/widgets/product_card.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import '../../../../../l10n/app_localizations.dart';

import '../../../../../core/di/injection.dart';
import '../../../domain/parameters/all_product_category_parameter.dart';
import '../../../domain/parameters/paginate_product_parameter.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/recommended_product/recommended_product_bloc.dart';
import '../../bloc/recommended_product/recommended_product_event.dart';
import '../product_category_bottom_scheet.dart';
import '../shop_banner_product.dart';

class ShopMain extends StatefulWidget {
  const ShopMain({super.key});

  @override
  State<ShopMain> createState() => _ShopMainState();
}

class _ShopMainState extends State<ShopMain>
    with AutomaticKeepAliveClientMixin {
  AllProductCategoryParameter allProductCategoryParameter =
      const AllProductCategoryParameter(isActive: true, isShowDeleted: false);
  PaginateProductParameter paginateProductParameter =
      const PaginateProductParameter(perPage: 2);
  PaginateProductParameter recommendedProductParameter =
      const PaginateProductParameter(
          perPage: 1, page: 1, isActive: true, isRecommended: true);
  final ScrollController scrollController = ScrollController();
  ProductBloc? productBloc;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (productBloc == null) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      // Load more products when near the bottom
      final currentState = productBloc!.state;

      if (currentState is PaginateProductLoadedState) {
        final pagination = currentState.pagination;
        if (pagination.currentPage < pagination.totalPages) {
          // Load next page
          final nextPageParameter = paginateProductParameter.copyWith(
            page: pagination.currentPage + 1,
          );
          productBloc!.add(PaginateProductEvent(nextPageParameter));
        }
      }
    }
  }

  void _onFiltersApplied(List<int> categoryIds, int? minPrice, int? maxPrice) {
    if (productBloc == null) return;

    // Update the parameter with new filters
    paginateProductParameter = paginateProductParameter.copyWith(
      categoryIds: categoryIds.isEmpty ? null : categoryIds,
      minPrice: minPrice,
      maxPrice: maxPrice,
      page: 1, // Reset to first page when filters change
    );

    // Trigger filter search (shows loading state)
    productBloc!.add(FilterProductEvent(paginateProductParameter));
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) {
            productBloc = getIt<ProductBloc>()
              ..add(PaginateProductEvent(paginateProductParameter));
            return productBloc!;
          },
        ),
        BlocProvider<RecommendedProductBloc>(
          create: (BuildContext context) => getIt<RecommendedProductBloc>()
            ..add(GetRecommendedProductEvent(recommendedProductParameter)),
        ),
        BlocProvider<AllProductCategoryBloc>(
          create: (BuildContext context) => getIt<AllProductCategoryBloc>()
            ..add(GetAllProductCategoryEvent(allProductCategoryParameter)),
        ),
      ],
      child: Builder(builder: (scopedCtx) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: MainTitleWidget(title: AppLocalizations.of(context)!.shop),
              ),
              const ShopBannerProduct(),
              ProductCategoryBottomScheet(
                onFiltersApplied: _onFiltersApplied,
              ),
              const ProductGridCards(),
            ],
          ),
        );
      }),
    );
  }
}
