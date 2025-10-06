import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/features/ticket/presentation/widgets/my_tickets.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../l10n/app_localizations.dart';

import '../widgets/new_tickets.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: PagesCommonAppBar(
          title: AppLocalizations.of(context)!.tickets,
          actionIcon: Iconsax.ticket,
          onActionTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey100, // фон для невыбранных
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.grey500,
                    tabs: [
                      Tab(
                        text: AppLocalizations.of(context)!.activeTickets,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.yourTickets,
                      )
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                NewTicketWidgets(),
                MyTicketsWidget(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
