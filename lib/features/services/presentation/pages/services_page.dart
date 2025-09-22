import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/services/presentation/widgets/fields/fields_main.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/product_category_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/section/section_main.dart';
import '../widgets/shop/shop_main.dart';
import '../widgets/tob_tabs.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: AppLocalizations.of(context)!.services,
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            ServiceTopTabs(controller: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ShopMain(key: PageStorageKey(ProductCategoryConstants.shopPageStorageKey)),
                  FieldsMain(key: PageStorageKey(ProductCategoryConstants.fieldsPageStorageKey)),
                  SectionMain(key: PageStorageKey(ProductCategoryConstants.sectionsPageStorageKey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
