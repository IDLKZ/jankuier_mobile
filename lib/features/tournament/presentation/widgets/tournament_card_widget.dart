import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/entities/tournament_entity.dart';

class TournamentCardWidget extends StatelessWidget {
  final TournamentEntity tournament;
  final bool isSelected;
  final VoidCallback? onTap;

  const TournamentCardWidget({
    super.key,
    required this.tournament,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 8 : 4,
              offset: Offset(0, isSelected ? 4 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Верхняя секция с изображением
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                child: _buildTournamentImage(),
              ),
            ),

            // Информация о турнире
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tournament.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Метки турнира
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (tournament.isInternational)
                          _buildChip('Межд.', Colors.blue),
                        if (tournament.isInternational && tournament.isMale)
                          SizedBox(width: 4.w),
                        if (tournament.isMale) _buildChip('М', Colors.green),
                        if (!tournament.isMale) _buildChip('Ж', Colors.pink),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Индикатор выбора
            if (isSelected)
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentImage() {
    if (tournament.image != null && tournament.image!.isNotEmpty) {
      return _buildImage(tournament.image!);
    }
    return _buildPlaceholder();
  }

  Widget _buildImage(String imageUrl) {
    final isSvg = imageUrl.toLowerCase().endsWith('.svg') ||
        imageUrl.toLowerCase().contains('.svg?');

    if (isSvg) {
      return SvgPicture.network(
        imageUrl,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => _buildPlaceholder(),
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.sports_soccer,
        size: 48.sp,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
