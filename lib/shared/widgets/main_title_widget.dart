import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  final Color mainColor;
  MainTitleWidget({
    super.key,
    this.mainColor = Colors.black,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
          color: mainColor,
        ));
  }
}
