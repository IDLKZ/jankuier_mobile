import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_product_parameter.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_state.dart';
import 'package:jankuier_mobile/features/services/presentation/widgets/product_card.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

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

class _ShopMainState extends State<ShopMain> {
  AllProductCategoryParameter allProductCategoryParameter =
      AllProductCategoryParameter(isActive: true, isShowDeleted: false);
  PaginateProductParameter paginateProductParameter =
      PaginateProductParameter(perPage: 12);
  PaginateProductParameter recomendedProductParameter =
      PaginateProductParameter(
          perPage: 1, page: 1, isActive: true, isRecommended: true);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => getIt<ProductBloc>()
            ..add(PaginateProductEvent(paginateProductParameter)),
        ),
        BlocProvider<RecommendedProductBloc>(
          create: (BuildContext context) => getIt<RecommendedProductBloc>()
            ..add(GetRecommendedProductEvent(recomendedProductParameter)),
        ),
        BlocProvider<AllProductCategoryBloc>(
          create: (BuildContext context) => getIt<AllProductCategoryBloc>()
            ..add(GetAllProductCategoryEvent(allProductCategoryParameter)),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: MainTitleWidget(title: "Магазин"),
            ),
            ShopBannerProduct(),
            ProductCategoryBottomScheet(),
            ProductGridCards(),
          ],
        ),
      ),
    );
  }
}
