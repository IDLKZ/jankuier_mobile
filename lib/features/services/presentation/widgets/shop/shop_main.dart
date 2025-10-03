import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_event.dart';
import 'package:jankuier_mobile/features/services/presentation/widgets/product_card.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import '../../../../../l10n/app_localizations.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_route_constants.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/utils/hive_utils.dart';
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
      const PaginateProductParameter(perPage: 20);
  PaginateProductParameter recommendedProductParameter =
      const PaginateProductParameter(
          perPage: 20, page: 1, isActive: true, isRecommended: true);
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
              const _MyOrdersBanner(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child:
                    MainTitleWidget(title: AppLocalizations.of(context)!.shop),
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

class _MyOrdersBanner extends StatefulWidget {
  const _MyOrdersBanner();

  @override
  State<_MyOrdersBanner> createState() => _MyOrdersBannerState();
}

class _MyOrdersBannerState extends State<_MyOrdersBanner> {
  final HiveUtils _hiveUtils = getIt<HiveUtils>();
  bool _hasUser = false;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    final user = await _hiveUtils.getCurrentUser();
    if (mounted) {
      setState(() {
        _hasUser = user != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasUser) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push(AppRouteConstants.MyProductOrdersPagePath);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.myOrders,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AppLocalizations.of(context)!.viewPurchaseHistory,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
