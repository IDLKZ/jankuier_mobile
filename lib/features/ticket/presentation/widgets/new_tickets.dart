import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../auth/presentation/pages/sign_in_page.dart';
import '../bloc/shows/ticketon_bloc.dart';
import '../bloc/shows/ticketon_state.dart';
import '../pages/ticket_webview_page.dart';

class NewTicketWidgets extends StatelessWidget {
  const NewTicketWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketonShowsBloc, TicketonShowsState>(
        builder: (context, state) {
      if (state is TicketonShowsShowsLoaded) {
        final filteredShows = state.shows.validShows;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          child: ListView.builder(
            itemCount: filteredShows.length,
            itemBuilder: (ctx, index) {
              final show = filteredShows[index];
              final event = state.shows.events[show.eventId];
              final place = state.shows.places[show.placeId];
              final city = place != null ? state.shows.cities[place.cityId] : null;

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: TicketCard(
                  image: event?.main != "" ? event?.main : event?.cover,
                  genre: event?.genre,
                  cityName: city?.name,
                  name: event?.name,
                  description: event?.description,
                  placeName: place?.name,
                  remark: event?.remark,
                  address: place?.address,
                  startAt: show.dateTime,
                  showId: show.id != null ? int.tryParse(show.id!) : null,
                ),
              );
            },
          ),
        );
      }
      if (state is TicketonShowsError) {
        return Center(child: Text(AppLocalizations.of(context)!.noActiveTicketsYet));
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
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

    Future<String?> _getAccessToken() async {
      final hiveUtils = getIt<HiveUtils>();
      final accessToken = await hiveUtils.getAccessToken();
      return accessToken;
    }

    return GestureDetector(
      onTap: () => _showDetailsBottomSheet(context, _getAccessToken),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Левая часть - изображение
            SizedBox(
              width: 100.w,
              height: 120.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      bottomLeft: Radius.circular(8.r),
                    ),
                    child: image != null
                        ? Image.network(
                            image!,
                            width: 120.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                FileUtils.LocalProductImage,
                                width: 120.w,
                                height: 140.h,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            FileUtils.LocalProductImage,
                            width: 120.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                          ),
                  ),

                  // Градиент оверлей для лучшей читаемости текста
                  Container(
                    width: 120.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),

                  // Город тег
                  Positioned(
                    bottom: 12.h,
                    left: 8.w,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        cityName ?? AppLocalizations.of(context)!.city,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Правая часть - содержимое
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Название события
                    Text(
                      name ?? AppLocalizations.of(context)!.event,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 8.h),

                    // Описание
                    if (description != null && description!.isNotEmpty) ...[
                      Text(
                        description!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                    ],

                    // Информация о месте и времени
                    Row(
                      children: [
                        // Иконка места
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Iconsax.location_copy,
                            size: 12.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 8.w),

                        // Место
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                placeName ?? AppLocalizations.of(context)!.venueNotSpecified,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              if (startAt != null)
                                Text(
                                  dateFormatter.format(startAt!.toLocal()),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Кнопки действий
                    // Row(
                    //   children: [
                    //     // Кнопка "Детали"
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () => _showDetailsBottomSheet(context, _getAccessToken),
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(vertical: 10.h),
                    //           decoration: BoxDecoration(
                    //             color: AppColors.grey100,
                    //             borderRadius: BorderRadius.circular(12.r),
                    //             border: Border.all(
                    //               color: AppColors.primary.withValues(alpha: 0.2),
                    //               width: 1,
                    //             ),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Iconsax.eye_copy,
                    //                 size: 14.sp,
                    //                 color: AppColors.primary,
                    //               ),
                    //               SizedBox(width: 6.w),
                    //               Text(
                    //                 'Детали',
                    //                 style: TextStyle(
                    //                   fontSize: 12.sp,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: AppColors.primary,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     SizedBox(width: 8.w),
                    //
                    //     // Кнопка "Купить"
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () async {
                    //           final token = await _getAccessToken();
                    //           if (token == null) {
                    //             context.go(AppRouteConstants.SignInPagePath);
                    //           } else {
                    //             Navigator.of(context).push(
                    //               MaterialPageRoute(
                    //                 builder: (context) => TicketWebViewPage(
                    //                   showId: showId.toString(),
                    //                   token: token,
                    //                 ),
                    //               ),
                    //             );
                    //           }
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(vertical: 10.h),
                    //           decoration: BoxDecoration(
                    //             gradient: AppColors.primaryGradient,
                    //             borderRadius: BorderRadius.circular(12.r),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Iconsax.ticket_discount_copy,
                    //                 size: 14.sp,
                    //                 color: Colors.white,
                    //               ),
                    //               SizedBox(width: 6.w),
                    //               Text(
                    //                 'Купить',
                    //                 style: TextStyle(
                    //                   fontSize: 12.sp,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsBottomSheet(BuildContext context, Future<String?> Function() getAccessToken) {
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'ru');

    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Хэндл
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Содержимое
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Изображение
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: image != null
                            ? Image.network(
                                image!,
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                FileUtils.LocalProductImage,
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 20.h),

                      // Теги
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Text(
                                genre?.toUpperCase() ?? AppLocalizations.of(context)!.sport,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Text(
                                cityName ?? "",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.success,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Название
                      Text(
                        name ?? "",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // HTML контент
                      Html(
                        data: remark ?? '',
                        style: {
                          "p": Style(
                            fontSize: FontSize(12.sp),
                            textAlign: TextAlign.left,
                            color: AppColors.black
                          ),
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Информация о месте и времени
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Место
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Iconsax.location_copy,
                                    size: 20.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.venue,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        address ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Время
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Iconsax.clock_copy,
                                    size: 20.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.dateAndTime,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        startAt != null
                                          ? dateFormatter.format(startAt!.toLocal())
                                          : AppLocalizations.of(context)!.timeNotSpecified,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
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

                      // Кнопка покупки
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () async {
                            final token = await getAccessToken();
                            if (token == null) {
                              context.go(AppRouteConstants.SignInPagePath);
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => TicketWebViewPage(
                                    showId: showId.toString(),
                                    token: token,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.ticket_discount_copy,
                                  size: 18.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  AppLocalizations.of(context)!.buyTickets,
                                  style: TextStyle(
                                    fontSize: 14.sp,
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
