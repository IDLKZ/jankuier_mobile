import 'package:flutter/material.dart';
import 'package:jankuier_mobile/features/home/presentation/widgets/edit_account_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: "Безопасность",
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: const EditAccountForm(showChangeEmail: false, showDeleteAccount: false),
    );
  }
}
