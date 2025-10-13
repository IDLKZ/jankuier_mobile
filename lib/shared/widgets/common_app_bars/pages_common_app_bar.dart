import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PagesCommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double commonHeight;
  final String title;
  final IconData actionIcon;
  final VoidCallback onActionTap;
  final IconData? leadingIcon;

  const PagesCommonAppBar({
    super.key,
    this.commonHeight = 80,
    this.leadingIcon,
    required this.title,
    required this.actionIcon,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(commonHeight.h),
      child: Container(
        height: commonHeight.h + MediaQuery.of(context).padding.top,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A388C),
              Color(0xFF004AD0),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Фон
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/app_bar_element.png',
                fit: BoxFit.fitHeight,
              ),
            ),

            // Центрируем контент
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 20.w,
                right: 20.w,
              ),
              child: Center(
                // <<<<<< --- Центрирование!
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // по вертикали центр
                  children: [
                    // Левая часть
                    Row(
                      children: [
                        if (leadingIcon != null) ...[
                          GestureDetector(
                            child: Icon(leadingIcon,
                                size: 20.sp, color: Colors.white),
                            onTap: () => context.pop(),
                          ),
                          SizedBox(width: 8.w),
                        ],
                        AutoSizeText(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Правая иконка
                    GestureDetector(
                      onTap: onActionTap,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: Icon(
                          actionIcon,
                          size: 30,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(commonHeight.h);
}
