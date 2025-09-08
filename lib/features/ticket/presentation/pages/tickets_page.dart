import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../shared/widgets/main_title_widget.dart';
import '../../../matches/presentation/widgets/qr_display_dialog.dart';
import '../bloc/shows/ticketon_state.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: "Билеты",
        actionIcon: Iconsax.ticket_discount_copy,
        onActionTap: () {},
      ),
      body: BlocBuilder<TicketonShowsBloc, TicketonShowsState>(
          builder: (context, state) {
        if (state is TicketonShowsShowsLoaded) {
          final filteredShows = state.shows.validShows;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: filteredShows.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.w,
                    builder: (ctx, index) {
                      final show = filteredShows[index];
                      final event = state.shows.events[show.eventId];
                      final place = state.shows.places[show.placeId];
                      final city = place != null
                          ? state.shows.cities[place.cityId]
                          : null;

                      return TicketCard(
                        image: event?.main,
                        genre: event?.genre,
                        cityName: city?.name,
                        name: event?.name,
                        description: event?.description,
                        placeName: place?.name,
                        remark: event?.remark,
                        address: place?.address,
                        startAt:
                            show.dateTime, // или другое поле с временем начала
                        showId: show.id != null
                            ? int.tryParse(show.id!)
                            : null, // теперь доступен showId из сущности
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        if (state is TicketonShowsError) {
          return Center(child: Text("Пока нет активных билетов"));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String? image;
  final String? genre;
  final String? cityName;
  final String? name;
  final String? description;
  final String? placeName;
  final String? remark;
  final String? address;
  final DateTime? startAt;
  final int? showId;
  const TicketCard({
    super.key,
    required this.image,
    required this.genre,
    required this.cityName,
    required this.name,
    required this.description,
    required this.placeName,
    required this.startAt,
    required this.showId,
    required this.remark,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'ru');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: image != null
                    ? Image.network(
                        image!,
                        width: double.infinity,
                        height: 160.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        FileUtils.LocalProductImage,
                        width: double.infinity,
                        height: 160.h,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    genre?.toUpperCase() ?? "ФУТБОЛ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    cityName ?? "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  description ?? "",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.location_copy,
                      size: 10.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        placeName ?? "-",
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.clock_copy,
                      size: 10.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 3.w),
                    Flexible(
                      child: Text(
                        dateFormatter.format(startAt!),
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            useRootNavigator: true,
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.r)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 4.h,
                                      margin: EdgeInsets.only(top: 12.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.textSecondary
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(2.r),
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        padding: EdgeInsets.all(20.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              child: image != null
                                                  ? Image.network(
                                                      image!,
                                                      width: double.infinity,
                                                      height: 200.h,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      FileUtils
                                                          .LocalProductImage,
                                                      width: double.infinity,
                                                      height: 200.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.w,
                                                      vertical: 6.h),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                  ),
                                                  child: Text(
                                                    genre?.toUpperCase() ??
                                                        "СПОРТ",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.w,
                                                      vertical: 6.h),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.success
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                  ),
                                                  child: Text(
                                                    cityName ?? "",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.success,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              name ?? "",
                                              style: TextStyle(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                                height: 1.3,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Html(
                                              data: remark,
                                              style: {
                                                "p": Style(
                                                    fontSize: FontSize(12.sp),
                                                    textAlign: TextAlign.left),
                                              },
                                            ),
                                            SizedBox(height: 20.h),
                                            Container(
                                              padding: EdgeInsets.all(16.w),
                                              decoration: BoxDecoration(
                                                color: AppColors.background,
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: AppColors.primary
                                                      .withOpacity(0.1),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(8.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                        child: Icon(
                                                          Iconsax.location_copy,
                                                          size: 20.sp,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                      SizedBox(width: 12.w),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Место проведения',
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .textSecondary,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 2.h),
                                                            Text(
                                                              address ?? "",
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors
                                                                    .textPrimary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 16.h),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(8.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                        child: Icon(
                                                          Iconsax.clock_copy,
                                                          size: 20.sp,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                      SizedBox(width: 12.w),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Дата и время',
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .textSecondary,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 2.h),
                                                            Text(
                                                              dateFormatter
                                                                  .format(
                                                                      startAt!),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors
                                                                    .textPrimary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.h),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Iconsax
                                                                .ticket_discount_copy,
                                                            size: 14.sp,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 4.w),
                                                          Text(
                                                            'Купить билеты',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.eye_copy,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Детали',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
