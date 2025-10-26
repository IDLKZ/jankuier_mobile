import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';

Widget buildBayanSuluWhiteCard(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      final url = Uri.parse('https://bayansulu.kz/');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLocalizations.of(context)?.localeName == "ru"
              ? Text(
                  AppLocalizations.of(context)!.withSupport,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Inter",
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                )
              : SizedBox(),
          AppLocalizations.of(context)?.localeName == "ru"
              ? SizedBox(
                  height: 10.h,
                )
              : SizedBox(),
          Image.asset("assets/images/bayan_sulu_white.png"),
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
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}
