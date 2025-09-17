import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';

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
      appBar: PagesCommonAppBar(
          title: "Билеты", actionIcon: Iconsax.ticket, onActionTap: () {}),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                text: "Активные билеты",
              )
            ]),
            TabBarView(children: [
              NewTicketWidgets(),
            ])
          ],
        ),
      ),
    );
  }
}
