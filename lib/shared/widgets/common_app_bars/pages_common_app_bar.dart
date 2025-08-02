import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagesCommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double commonHeight = 110;
  const PagesCommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: commonHeight.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        height: commonHeight.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          gradient: const LinearGradient(
            begin: AlignmentDirectional(-0.5, -1.0),
            end: AlignmentDirectional(0.0, 0.5),
            colors: [
              Color(0xFF0A388C),
              Color(0xFF004AD0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(commonHeight.h);
}
