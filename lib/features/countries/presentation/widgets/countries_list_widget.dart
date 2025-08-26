import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/entities/sota_pagination_entity.dart';
import '../../data/entities/country_entity.dart';
import 'country_item_widget.dart';

class CountriesListWidget extends StatelessWidget {
  final SotaPaginationResponse<CountryEntity> countries;
  final Function(CountryEntity)? onCountrySelected;

  const CountriesListWidget({
    super.key,
    required this.countries,
    this.onCountrySelected,
  });

  @override
  Widget build(BuildContext context) {
    if (countries.results.isEmpty) {
      return Center(
        child: Text(
          'Нет данных о странах',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: countries.results.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final country = countries.results[index];
        return CountryItemWidget(
          country: country,
          onTap: onCountrySelected != null 
              ? () => onCountrySelected!(country)
              : null,
        );
      },
    );
  }
}