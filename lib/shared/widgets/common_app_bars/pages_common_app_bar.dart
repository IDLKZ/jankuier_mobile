import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagesCommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double commonHeight;
  final String title;
  final IconData actionIcon;
  final VoidCallback onActionTap;

  const PagesCommonAppBar({
    super.key,
    this.commonHeight = 100,
    required this.title,
    required this.actionIcon,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: commonHeight.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        height: commonHeight.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
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
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/app_bar_element.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w)
                    .copyWith(bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 🏷️ Заголовок
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),

                    // 🔧 Действие или пустой SizedBox
                    GestureDetector(
                        onTap: onActionTap,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.2)),
                          child: IconButton(
                            icon: Icon(actionIcon,
                                size: 30,
                                color: Colors.white.withValues(alpha: 0.7)),
                            onPressed: () {
                              // действие при нажатии
                            },
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(commonHeight.h);
}
