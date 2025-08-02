import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color mainColor;
  final String? secondTitle;
  final double secondFontSize;
  final Color? secondColor;
  final VoidCallback? onTap;
  const MainTitleWidget({
    super.key,
    this.mainColor = Colors.black,
    this.fontSize = 16,
    this.secondFontSize = 16,
    required this.title, this.secondTitle, this.secondColor, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: fontSize.sp,
              color: mainColor,
            )),
        if (secondTitle != null) GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(secondTitle!,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: secondFontSize.sp,
                    color: secondColor,
                  )),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.black.withOpacity(0.6),)
            ],
          ),
        )
      ],
    );
  }
}
