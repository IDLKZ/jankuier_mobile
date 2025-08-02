import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/services/presentation/widgets/product_card.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../shop_banner_product.dart';

class ShopMainWidget extends StatelessWidget {
  const ShopMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: MainTitleWidget(title: "Магазин"),
          ),
          ShopBannerProduct(
            imagePath: 'assets/images/shop_banner.png',
            title: 'Обновленная форма',
            subtitle: 'KFF KAZAKHSTAN',
            buttonText: 'Купить',
            onPressed: () {
              print('Купить нажато');
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: MainTitleWidget(title: "Новые товары"),
          ),
          ProductGridCards(),
        ],
      ),
    );
  }
}
