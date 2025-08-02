import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_route_constants.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../widgets/edit_profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesCommonAppBar(
        title: "Профиль",
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
      ),
      body: EditProfilePage(
        userName: "Айжан Нурсултанова",
        onAvatarTap: () {
          // Открыть выбор аватара
        },
        onPersonalDataTap: () {
          context.push(AppRouteConstants.EditAccountPagePath);
        },
        onSecurityTap: () {
          context.push(AppRouteConstants.EditPasswordPagePath);
        },
        onLogout: () {
          // Логаут
        },
      ),
    );
  }
}
