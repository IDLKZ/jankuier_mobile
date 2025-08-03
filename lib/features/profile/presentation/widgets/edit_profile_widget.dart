import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

class EditProfilePage extends StatelessWidget {
  final String userName;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onPersonalDataTap;
  final VoidCallback? onSecurityTap;
  final VoidCallback? onLogout;

  const EditProfilePage({
    Key? key,
    required this.userName,
    this.onAvatarTap,
    this.onPersonalDataTap,
    this.onSecurityTap,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTitleWidget(title: 'Редактировать профиль'),
                const SizedBox(height: 20),
                // Avatar + Name Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 26.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: onAvatarTap,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF6F7F9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 36,
                            color: Color(0xFFBDBDBD),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Личные данные
                _ProfileTile(
                  icon: Icons.description_outlined,
                  text: "Личные данные",
                  onTap: onPersonalDataTap,
                ),
                SizedBox(height: 8.h),
                // Безопасность
                _ProfileTile(
                  icon: Icons.lock_outline,
                  text: "Безопасность",
                  onTap: onSecurityTap,
                ),
                SizedBox(height: 16.h),
                // Выход
                GestureDetector(
                  onTap: onLogout,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: Color(0xFFFF4C4C)),
                        SizedBox(width: 12.w),
                        Text(
                          "Выход",
                          style: TextStyle(
                            color: const Color(0xFFFF4C4C),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Универсальная плитка меню
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _ProfileTile({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFBDBDBD)),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
