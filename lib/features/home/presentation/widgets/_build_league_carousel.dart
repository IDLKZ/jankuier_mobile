import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../tournament/data/entities/tournament_entity.dart';

Widget buildLeagueCarousel(
    List<TournamentEntity> tournaments,
    TournamentEntity? selectedTournament,
    void Function(TournamentEntity) onTournamentSelected)
{
  return SizedBox(
    height: 50.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tournaments.length,
      itemBuilder: (context, index) {
        final tournament = tournaments[index];
        return Container(
          margin: EdgeInsets.only(right: 16.w),
          child: _buildLeagueItem(tournament, selectedTournament, onTournamentSelected),
        );
      },
    ),
  );
}

Widget _buildLeagueItem(TournamentEntity tournament, TournamentEntity? selectedTournament, void Function(TournamentEntity) onTournamentSelected) {
  final isSelected = selectedTournament?.id == tournament.id;

  return GestureDetector(
    onTap: () {
      onTournamentSelected(tournament);
    },
    child: Container(
      width: 50.h,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: AppColors.gradientStart, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.gradientStart.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: buildTournamentImage(tournament.image!),
      ),
    ),
  );
}

Widget buildTournamentImage(String imageUrl) {
  final isSvg = imageUrl.toLowerCase().endsWith('.svg') ||
      imageUrl.toLowerCase().contains('.svg?');

  if (isSvg) {
    return SvgPicture.network(
      imageUrl,
      width: 40.h,
      height: 40.h,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => _buildImagePlaceholder(),
    );
  } else {
    return Image.network(
      imageUrl,
      width: 40.h,
      height: 40.h,
      fit: BoxFit.fitHeight,
      errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildImagePlaceholder();
      },
    );
  }
}

Widget _buildImagePlaceholder() {
  return Container(
    color: Colors.grey[200],
    child: const Icon(
      Icons.sports_soccer,
      color: Colors.grey,
      size: 30,
    ),
  );
}

