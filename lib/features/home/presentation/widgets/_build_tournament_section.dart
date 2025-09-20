import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/sota_api_constants.dart';
import '../../../tournament/data/entities/tournament_entity.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_bloc.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_state.dart';
import '_build_league_carousel.dart';

Widget buildTournamentSection(TournamentEntity? selectedTournament,
    void Function(TournamentEntity) onTournamentSelected) {
  return Container(
    padding: EdgeInsets.all(20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Турниры',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16.h),
        _buildTournamentCarousel(selectedTournament, onTournamentSelected),
      ],
    ),
  );
}

Widget _buildTournamentCarousel(TournamentEntity? selectedTournament,
    void Function(TournamentEntity) onTournamentSelected) {
  return BlocBuilder<GetTournamentBloc, GetTournamentStateState>(
    builder: (context, state) {
      if (state is GetTournamentStateLoadingState) {
        return _buildLoadingCarousel();
      } else if (state is GetTournamentStateSuccessState) {
        // Filter only football tournaments with seasons (like in tournament_selection_grid.dart)
        const excludedSeasonIds = [92, 71, 24, 108, 17];
        final tournaments = state.tournaments.results
            .where((tournament) =>
        tournament.sport == SotaApiConstant.FootballID &&
            tournament.seasons.isNotEmpty &&
            tournament.image != null &&
            tournament.image!.isNotEmpty &&
            !tournament.seasons.any((season) => excludedSeasonIds.contains(season.id))
        )
        // .take(6) // Limit to 6 tournaments for carousel
            .toList();

        if (tournaments.isEmpty) {
          return _buildEmptyState();
        }

        // Auto-select first tournament if none selected
        if (selectedTournament == null && tournaments.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onTournamentSelected(tournaments.first);
          });
        }

        return buildLeagueCarousel(tournaments, selectedTournament, onTournamentSelected);
      } else if (state is GetTournamentStateFailedState) {
        return _buildErrorState();
      }
      return const SizedBox();
    },
  );
}

Widget _buildLoadingCarousel() {
  return SizedBox(
    height: 50.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 16.w),
          width: 50.h,
          height: 50.h,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildEmptyState() {
  return SizedBox(
    height: 70.h,
    child: Center(
      child: Text(
        'Турниры не найдены',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget _buildErrorState() {
  return SizedBox(
    height: 70.h,
    child: Center(
      child: Text(
        'Ошибка загрузки турниров',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.red,
        ),
      ),
    ),
  );
}