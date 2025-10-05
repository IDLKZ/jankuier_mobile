import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import 'package:jankuier_mobile/core/common/entities/file_entity.dart';
import '../../../../l10n/app_localizations.dart';

class EditProfilePage extends StatelessWidget {
  final String userName;
  final FileEntity? userImage;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onPersonalDataTap;
  final VoidCallback? onSecurityTap;
  final VoidCallback? onMyOrdersTap;
  final VoidCallback? onMyBookingsTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onLogout;
  final VoidCallback? onDeleteAccount;

  const EditProfilePage({
    Key? key,
    required this.userName,
    this.userImage,
    this.onAvatarTap,
    this.onPersonalDataTap,
    this.onSecurityTap,
    this.onMyOrdersTap,
    this.onMyBookingsTap,
    this.onCartTap,
    this.onLogout,
    this.onDeleteAccount,
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
                MainTitleWidget(title: AppLocalizations.of(context)!.editProfile),
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
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F7F9),
                            shape: BoxShape.circle,
                            image: userImage != null
                                ? DecorationImage(
                                    image: NetworkImage(ApiConstant.GetImageUrl(
                                        userImage!.filePath)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: userImage == null
                              ? const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 36,
                                  color: Color(0xFFBDBDBD),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userName,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Личные данные
                _ProfileTile(
                  icon: Icons.description_outlined,
                  text: AppLocalizations.of(context)!.personalData,
                  onTap: onPersonalDataTap,
                ),
                SizedBox(height: 8.h),
                // Безопасность
                _ProfileTile(
                  icon: Icons.lock_outline,
                  text: AppLocalizations.of(context)!.security,
                  onTap: onSecurityTap,
                ),
                SizedBox(height: 8.h),
                // Мои заказы
                _ProfileTile(
                  icon: Icons.shopping_bag_outlined,
                  text: AppLocalizations.of(context)!.myOrders,
                  onTap: onMyOrdersTap,
                ),
                SizedBox(height: 8.h),
                // Мои брони
                _ProfileTile(
                  icon: Icons.event_note_outlined,
                  text: AppLocalizations.of(context)!.myBookings,
                  onTap: onMyBookingsTap,
                ),
                SizedBox(height: 8.h),
                // Корзина
                _ProfileTile(
                  icon: Icons.shopping_cart_outlined,
                  text: AppLocalizations.of(context)!.cart,
                  onTap: onCartTap,
                ),
                SizedBox(height: 8.h),
                // Выход
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  text: AppLocalizations.of(context)!.logout,
                  onTap: onLogout,
                  textColor: const Color(0xFFFF4C4C),
                  iconColor: const Color(0xFFFF4C4C),
                ),
                if (onDeleteAccount != null) ...[
                  SizedBox(height: 8.h),
                  // Удаление аккаунта
                  _ProfileTile(
                    icon: Icons.delete_forever_rounded,
                    text: AppLocalizations.of(context)!.deleteAccount,
                    onTap: onDeleteAccount,
                    textColor: const Color(0xFFDC3545),
                    iconColor: const Color(0xFFDC3545),
                  ),
                ],
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
  final Color? textColor;
  final Color? iconColor;

  const _ProfileTile({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
    this.textColor,
    this.iconColor,
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
            Icon(icon, color: iconColor ?? const Color(0xFFBDBDBD)),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor ?? const Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
