import 'package:flutter/material.dart';

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
          // Навигация к личным данным
        },
        onSecurityTap: () {
          // Навигация к безопасности
        },
        onLogout: () {
          // Логаут
        },
      )
      ,
    );
  }
}