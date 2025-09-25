import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/app_localizations.dart';

import '../../data/entities/country_entity.dart';

class CountryItemWidget extends StatelessWidget {
  final CountryEntity country;
  final VoidCallback? onTap;

  const CountryItemWidget({
    super.key,
    required this.country,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      child: Row(
        children: [
          // Флаг страны
          Container(
            width: 40.w,
            height: 28.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: country.flagImage.isNotEmpty
                  ? _buildFlagImage(country.flagImage)
                  : _buildFlagPlaceholder(),
            ),
          ),
          SizedBox(width: 12.w),
          // Информация о стране
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${AppLocalizations.of(context)!.nationalTeam} ${country.name}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildFlagImage(String imageUrl) {
    final isSvg = imageUrl.toLowerCase().endsWith('.svg') || 
                  imageUrl.toLowerCase().contains('.svg?');
    
    if (isSvg) {
      return Builder(
        builder: (context) {
          try {
            return SvgPicture.network(
              imageUrl,
              width: 40.w,
              height: 28.h,
              fit: BoxFit.cover,
              placeholderBuilder: (context) => _buildFlagPlaceholder(),
            );
          } catch (e) {
            return _buildFlagPlaceholder();
          }
        },
      );
    } else {
      return Image.network(
        imageUrl,
        width: 40.w,
        height: 28.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFlagPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildFlagPlaceholder();
        },
      );
    }
  }

  Widget _buildFlagPlaceholder() {
    return Container(
      width: 40.w,
      height: 28.h,
      color: Colors.grey[100],
      child: Icon(
        Icons.flag_outlined,
        size: 16.sp,
        color: Colors.grey[400],
      ),
    );
  }
}
