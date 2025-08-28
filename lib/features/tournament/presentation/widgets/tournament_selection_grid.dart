import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/entities/sota_pagination_entity.dart';
import '../../../../core/constants/sota_api_constants.dart';
import '../../data/entities/tournament_entity.dart';
import 'tournament_card_widget.dart';

class TournamentSelectionGrid extends StatelessWidget {
  final SotaPaginationResponse<TournamentEntity> tournaments;
  final int? selectedTournamentId;
  final Function(TournamentEntity tournament)? onTournamentSelected;

  const TournamentSelectionGrid({
    super.key,
    required this.tournaments,
    this.selectedTournamentId,
    this.onTournamentSelected,
  });

  @override
  Widget build(BuildContext context) {
    final footballTournaments = tournaments.results
        .where((tournament) =>
            tournament.sport == SotaApiConstant.FootballID &&
            tournament.seasons.isNotEmpty)
        .toList();
    if (footballTournaments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer_outlined,
              size: 64.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'Турниры не найдены',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Попробуйте изменить фильтры поиска',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: footballTournaments.length,
        itemBuilder: (context, index) {
          final tournament = footballTournaments[index];
          final isSelected = selectedTournamentId == tournament.id;

          return TournamentCardWidget(
            tournament: tournament,
            isSelected: isSelected,
            onTap: () {
              onTournamentSelected?.call(tournament);
            },
          );
        },
      ),
    );
  }
}
