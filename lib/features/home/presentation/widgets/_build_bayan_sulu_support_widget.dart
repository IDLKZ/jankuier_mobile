import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

Widget buildBayanSuluYellowCard(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    height: 100.h,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r), color: Color(0xFFFFC905)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppLocalizations.of(context)?.localeName == "ru"
            ? Text(
                AppLocalizations.of(context)!.withSupport,
                style: TextStyle(
                    fontSize: 12.sp, fontFamily: "Inter", color: Colors.black),
              )
            : SizedBox(),
        AppLocalizations.of(context)?.localeName == "ru"
            ? SizedBox(
                height: 10.h,
              )
            : SizedBox(),
        Image.asset("assets/images/bayan_sulu_black.png"),
        AppLocalizations.of(context)?.localeName == "kk"
            ? SizedBox(
                height: 10.h,
              )
            : SizedBox(),
        AppLocalizations.of(context)?.localeName == "kk"
            ? Text(
                AppLocalizations.of(context)!.withSupport,
                style: TextStyle(
                    fontSize: 12.sp, fontFamily: "Inter", color: Colors.black),
              )
            : SizedBox(),
      ],
    ),
  );
}
