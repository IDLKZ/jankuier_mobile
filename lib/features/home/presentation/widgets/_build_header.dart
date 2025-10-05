import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/localization_service.dart';
import '../../../../l10n/app_localizations.dart';

Widget buildHeader(BuildContext context) {
  return FutureBuilder<LocalizationService>(
    future: getIt.getAsync<LocalizationService>(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container(
          height: 120.h,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const SafeArea(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      final localizationService = snapshot.data!;

      return Container(
        height: 120.h,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.home,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    // Language switcher button
                    GestureDetector(
                      onTap: () {
                        localizationService.cycleToNextLanguage();
                      },
                      child: Container(
                        width: 40.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: AnimatedBuilder(
                            animation: localizationService,
                            builder: (context, child) {
                              return Text(
                                localizationService
                                    .getCurrentLanguageDisplayName(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 40.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        onTap: () {
                          context
                              .push(AppRouteConstants.MyNotificationsPagePath);
                        },
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
