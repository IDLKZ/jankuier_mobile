import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

Widget buildBayanSuluBlueCard(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    height: 100.h,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r), color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppLocalizations.of(context)?.localeName == "ru"
            ? Text(
                AppLocalizations.of(context)!.withSupport,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Inter",
                    color: Color(0xFF0148C9).withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold),
              )
            : SizedBox(),
        SizedBox(
          height: 10.h,
        ),
        Image.asset("assets/images/bayan_sulu_blue.png"),
        AppLocalizations.of(context)?.localeName == "kk"
            ? SizedBox(
                height: 10.h,
              )
            : SizedBox(),
        AppLocalizations.of(context)?.localeName == "kk"
            ? Text(
                AppLocalizations.of(context)!.withSupport,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Inter",
                    color: Color(0xFF0148C9).withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold),
              )
            : SizedBox(),
      ],
    ),
  );
}
