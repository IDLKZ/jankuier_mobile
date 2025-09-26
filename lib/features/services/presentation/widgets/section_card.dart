import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/core/utils/localization_helper.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/academy_entity.dart';
import '../../../../l10n/app_localizations.dart';

class SectionCardWidget extends StatelessWidget {
  final AcademyEntity entity;
  final VoidCallback onTap;

  const SectionCardWidget({
    super.key,
    required this.entity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 Картинка
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: entity.image != null
                ? Image.network(
                    ApiConstant.GetImageUrl(entity.image?.filePath ?? ""),
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    FileUtils.LocalProductImage,
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 12.h),

          // 🏷 Название и описание
          Text(
            context.localizedDirectTitle(entity),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            context.localizedDirectDescription(entity),
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12.h),

          // ⏱ Длительность и возраст
          Row(
            children: [
              Icon(Icons.access_time, size: 14.sp, color: const Color(0xFF838383)),
              SizedBox(width: 4.w),
              Text(
                  "${entity.averageTrainingTimeInMinute} ${AppLocalizations.of(context)!.minutes}",
                  style: TextStyle(fontSize: 12.sp, color: const Color(0xFF838383))),
              SizedBox(width: 12.w),
              Icon(Icons.person, size: 14.sp, color: const Color(0xFF838383)),
              SizedBox(width: 4.w),
              Text(
                  "${entity.minAge}-${entity.maxAge} ${AppLocalizations.of(context)!.years}",
                  style: TextStyle(fontSize: 12.sp, color: const Color(0xFF838383))),
            ],
          ),

          SizedBox(height: 12.h),

          // 💰 Цена и кнопка
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${entity.averagePrice}KZT/${AppLocalizations.of(context)!.month}",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0247C3),
                ),
              ),
              OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0247C3)),
                  foregroundColor: const Color(0xFF0247C3),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.register,
                    style: TextStyle(fontSize: 12.sp)),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
                color: const Color(0x80EDF0F9),
                borderRadius: BorderRadius.circular(5.r)),
            padding:
                EdgeInsetsGeometry.symmetric(horizontal: 10.h, vertical: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined,
                    size: 14.sp, color: const Color(0xFF838383)),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    context.localizedDirectAddress(entity),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF838383),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
