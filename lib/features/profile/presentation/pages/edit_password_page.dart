import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jankuier_mobile/features/home/presentation/widgets/edit_account_widget.dart';

import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesCommonAppBar(
        title: "Безопасность",
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: EditAccountForm(showChangeEmail: false, showDeleteAccount: false),
    );
  }
}
