import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/main_selection_service.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../domain/parameters/get_country_parameter.dart';
import '../../data/entities/country_entity.dart';
import '../bloc/get_country_bloc.dart';
import '../bloc/get_country_event.dart';
import '../bloc/get_country_state.dart';
import '../widgets/countries_list_widget.dart';
import '../widgets/countries_loading_widget.dart';
import '../widgets/countries_error_widget.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  Future<void> _onCountrySelected(BuildContext context, CountryEntity country) async {
    try {
      final mainSelectionService = getIt<MainSelectionService>();
      await mainSelectionService.saveMainCountry(country);
      
      if (!context.mounted) return;
      
      Fluttertoast.showToast(
        msg: 'Выбрана страна: ${country.name}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      
      context.pushNamed(AppRouteConstants.TournamentSelectionPageName);
    } catch (e) {
      if (!context.mounted) return;
      
      Fluttertoast.showToast(
        msg: 'Ошибка сохранения страны',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetCountryBloc>()
        ..add(GetCountryEvent(const GetCountryParameter())),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Страны',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<GetCountryBloc, GetCountryStateState>(
          builder: (context, state) {
            if (state is GetCountryStateLoadingState) {
              return const CountriesLoadingWidget();
            } else if (state is GetCountryStateSuccessState) {
              return CountriesListWidget(
                countries: state.countries,
                onCountrySelected: (country) => _onCountrySelected(context, country),
              );
            } else if (state is GetCountryStateFailedState) {
              return CountriesErrorWidget(
                error: state.failureData.message ?? "Error",
                onRetry: () {
                  context.read<GetCountryBloc>().add(
                        GetCountryEvent(const GetCountryParameter()),
                      );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
