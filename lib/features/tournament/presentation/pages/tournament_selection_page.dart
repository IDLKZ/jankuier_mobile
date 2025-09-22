import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/main_selection_service.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../domain/parameters/get_tournament_parameter.dart';
import '../../data/entities/tournament_entity.dart';
import '../bloc/get_tournaments/get_tournament_bloc.dart';
import '../bloc/get_tournaments/get_tournament_event.dart';
import '../bloc/get_tournaments/get_tournament_state.dart';
import '../widgets/tournament_selection_grid.dart';
import '../widgets/tournament_loading_grid.dart';
import '../widgets/tournament_error_widget.dart';
import '../widgets/tournament_filters_widget.dart';

class TournamentSelectionPage extends StatefulWidget {
  final Function(int tournamentId, String tournamentName)? onTournamentSelected;
  final int? selectedTournamentId;

  const TournamentSelectionPage({
    super.key,
    this.onTournamentSelected,
    this.selectedTournamentId,
  });

  @override
  State<TournamentSelectionPage> createState() =>
      _TournamentSelectionPageState();
}

class _TournamentSelectionPageState extends State<TournamentSelectionPage> {
  late GetTournamentBloc _bloc;
  GetTournamentParameter _currentParams = const GetTournamentParameter();
  bool _hasMainCountry = false;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<GetTournamentBloc>();
    _checkMainCountry();
  }

  Future<void> _checkMainCountry() async {
    final mainSelectionService = getIt<MainSelectionService>();
    final hasCountry = await mainSelectionService.hasMainCountry();
    
    if (!hasCountry) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Сначала выберите страну',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        context.pop();
      }
      return;
    }
    
    setState(() {
      _hasMainCountry = true;
    });
    _loadTournaments();
  }

  Future<void> _onTournamentSelected(TournamentEntity tournament) async {
    try {
      final mainSelectionService = getIt<MainSelectionService>();
      await mainSelectionService.saveMainTournament(tournament);
      
      if (!mounted) return;
      
      // Get the selected season info for the toast
      final activeSeason = await mainSelectionService.getActiveSeason();
      final seasonInfo = activeSeason != null ? ' (Сезон: ${activeSeason.name})' : '';
      
      Fluttertoast.showToast(
        msg: 'Выбран турнир: ${tournament.name}$seasonInfo',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      
      // If there's an external callback, call it
      if (widget.onTournamentSelected != null) {
        widget.onTournamentSelected!(tournament.id, tournament.name);
        context.pop();
      } else {
        // Navigate to standings page when no external callback
        context.go(AppRouteConstants.StandingsPagePath);
      }
    } catch (e) {
      if (!mounted) return;
      
      Fluttertoast.showToast(
        msg: 'Ошибка сохранения турнира',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _loadTournaments() {
    _bloc.add(GetTournamentEvent(_currentParams));
  }

  void _onFiltersChanged(GetTournamentParameter params) {
    setState(() {
      _currentParams = params;
    });
    _loadTournaments();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Выберите турнир',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            // Фильтры
            TournamentFiltersWidget(
              currentParams: _currentParams,
              onFiltersChanged: _onFiltersChanged,
            ),

            // Содержимое
            Expanded(
              child: _hasMainCountry 
                ? BlocBuilder<GetTournamentBloc, GetTournamentStateState>(
                    builder: (context, state) {
                      if (state is GetTournamentStateLoadingState) {
                        return const TournamentLoadingGrid();
                      } else if (state is GetTournamentStateSuccessState) {
                    return TournamentSelectionGrid(
                      tournaments: state.tournaments,
                      selectedTournamentId: widget.selectedTournamentId,
                      onTournamentSelected: _onTournamentSelected,
                    );
                  } else if (state is GetTournamentStateFailedState) {
                    return TournamentErrorWidget(
                      error: state.failureData.message ?? 'Unknown error',
                      onRetry: _loadTournaments,
                    );
                      }
                      return const SizedBox();
                    },
                  )
                : const TournamentLoadingGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
