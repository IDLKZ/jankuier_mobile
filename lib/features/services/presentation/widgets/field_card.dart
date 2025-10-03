import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/core/utils/localization_helper.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';
import 'package:jankuier_mobile/features/booking_field_party/domain/parameters/create_booking_field_party_request_parameter.dart';
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/create_booking_field_party_request/create_booking_field_party_request_bloc.dart';
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/create_booking_field_party_request/create_booking_field_party_request_event.dart';
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/create_booking_field_party_request/create_booking_field_party_request_state.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party_schedule_preview/field_party_schedule_preview_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../data/entities/field/field_schedule_record_entity.dart';
import '../../domain/parameters/field_party_schedule_preview_parameter.dart';
import '../../domain/use_cases/field/get_field_party_schedule_preview_case.dart';
import '../bloc/field_party_schedule_preview/field_party_schedule_preview_event.dart';
import '../bloc/field_party_schedule_preview/field_party_schedule_preview_state.dart';
import '../../../../l10n/app_localizations.dart';

class FieldCard extends StatelessWidget {
  final FieldPartyEntity fieldPartyEntity;

  const FieldCard({
    super.key,
    required this.fieldPartyEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: fieldPartyEntity.image != null
                ? Image.network(
                    ApiConstant.GetImageUrl(
                        fieldPartyEntity.image?.filePath ?? ""),
                    width: double.infinity,
                    height: 120.h,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    FileUtils.LocalProductImage,
                    width: double.infinity,
                    height: 120.h,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 12.h),
          Text(
            context.localizedDirectTitle(fieldPartyEntity),
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          SizedBox(height: 2.h),
          Text(
            fieldPartyEntity.field != null
                ? context.localizedDirectTitle(fieldPartyEntity.field)
                : '',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _IconText(
                  svg: 'assets/icons/field_size.svg',
                  text:
                      "${fieldPartyEntity.widthM} x ${fieldPartyEntity.lengthM} м."),
              SizedBox(width: 12.w),
              _IconText(
                  svg: 'assets/icons/clock.svg',
                  text:
                      "${fieldPartyEntity.activeScheduleSetting?.sessionMinuteInt ?? 60} ${AppLocalizations.of(context)!.minutes}"),
              SizedBox(width: 12.w),
              _IconText(
                  svg: 'assets/icons/group.svg',
                  text: "${fieldPartyEntity.personQty}"),
              SizedBox(width: 12.w),
              _IconText(
                  svg: 'assets/icons/city.svg',
                  text: "${fieldPartyEntity.field?.city?.titleRu}"),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                "${fieldPartyEntity.activeScheduleSetting?.pricePerTime.first.price ?? 5000} KZT",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF0247C3),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 36.h,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.9,
                          maxChildSize: 0.9,
                          minChildSize: 0.4,
                          expand: false,
                          builder: (_, scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r)),
                              ),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: FieldBookingCard(
                                  fieldPartyEntity: fieldPartyEntity,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.book,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final String svg;
  final String text;

  const _IconText({required this.svg, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svg, width: 14.w, height: 14.w),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(fontSize: 11.sp, color: const Color(0xFF838383)),
        ),
      ],
    );
  }
}

class FieldBookingCard extends StatefulWidget {
  final FieldPartyEntity fieldPartyEntity;

  const FieldBookingCard({
    super.key,
    required this.fieldPartyEntity,
  });

  @override
  State<FieldBookingCard> createState() => _FieldBookingCardState();
}

class _FieldBookingCardState extends State<FieldBookingCard> {
  late FieldPartySchedulePreviewParameter parameter;
  late FieldPartySchedulePreviewBloc previewBloc;
  late CreateBookingFieldPartyRequestBloc createBookingBloc;
  ScheduleRecordEntity? scheduleRecordEntity;

  @override
  void initState() {
    super.initState();
    parameter = FieldPartySchedulePreviewParameter(
      fieldPartyId: widget.fieldPartyEntity.id,
      day: DateTime.now(),
    );
    previewBloc = FieldPartySchedulePreviewBloc(
      getFieldPartySchedulePreviewCase:
          getIt<GetFieldPartySchedulePreviewCase>(),
    )..add(GetFieldPartySchedulePreviewEvent(parameter));

    createBookingBloc = getIt<CreateBookingFieldPartyRequestBloc>();
  }

  @override
  void dispose() {
    previewBloc.close();
    createBookingBloc.close();
    super.dispose();
  }

  void _onScheduleSelect(ScheduleRecordEntity _scheduleRecordEntity) {
    setState(() {
      scheduleRecordEntity = _scheduleRecordEntity;
    });
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      parameter = FieldPartySchedulePreviewParameter(
        fieldPartyId: widget.fieldPartyEntity.id,
        day: newDate,
      );
      // Reset selected schedule when date changes
      scheduleRecordEntity = null;
    });
    previewBloc.add(GetFieldPartySchedulePreviewEvent(
      FieldPartySchedulePreviewParameter(
        fieldPartyId: widget.fieldPartyEntity.id,
        day: newDate,
      ),
    ));
  }

  Future<void> _handlePayment() async {
    // Check if user is authenticated
    final hiveUtils = getIt<HiveUtils>();
    final user = await hiveUtils.getCurrentUser();

    if (user == null) {
      // Show dialog to login
      if (!mounted) return;
      _showLoginDialog();
      return;
    }

    // Check if schedule is selected
    if (scheduleRecordEntity == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectTime),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Create booking request
    _createBookingRequest(user);
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          AppLocalizations.of(context)!.authorizationRequired,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)!.loginFirstToBook,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.push(AppRouteConstants.SignInPagePath);
            },
            child: Text(
              AppLocalizations.of(context)!.signIn,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createBookingRequest(UserEntity user) {
    final parameter = CreateBookingFieldPartyRequestParameter(
      fieldPartyId: widget.fieldPartyEntity.id,
      day: this.parameter.day.toIso8601String().split('T')[0],
      startAt: scheduleRecordEntity!.startAt,
      endAt: scheduleRecordEntity!.endAt,
      email: user.email,
      phone: user.phone,
    );

    createBookingBloc.add(CreateBookingFieldPartyRequestSubmitted(parameter));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: previewBloc),
        BlocProvider.value(value: createBookingBloc),
      ],
      child: BlocListener<CreateBookingFieldPartyRequestBloc,
          CreateBookingFieldPartyRequestState>(
        listener: (context, state) {
          if (state is CreateBookingFieldPartyRequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.bookingRequestCreated),
                backgroundColor: AppColors.success,
              ),
            );
            context.push(AppRouteConstants.MyBookingFieldRequestsPagePath);
          } else if (state is CreateBookingFieldPartyRequestError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🖼️ Картинка
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: widget.fieldPartyEntity.image != null
                    ? Image.network(
                        ApiConstant.GetImageUrl(
                          widget.fieldPartyEntity.image?.filePath ?? "",
                        ),
                        width: double.infinity,
                        height: 120.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        FileUtils.LocalProductImage,
                        width: double.infinity,
                        height: 120.h,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 12.h),

              /// 📋 Контент
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.localizedDirectTitle(widget.fieldPartyEntity),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(height: 2.h),
                    Text(
                        widget.fieldPartyEntity.field != null
                            ? context.localizedDirectTitle(
                                widget.fieldPartyEntity.field)
                            : '',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey)),

                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        _IconText(
                            svg: 'assets/icons/field_size.svg',
                            text:
                                "${widget.fieldPartyEntity.widthM} x ${widget.fieldPartyEntity.lengthM} м."),
                        SizedBox(width: 12.w),
                        _IconText(
                            svg: 'assets/icons/clock.svg',
                            text:
                                "${widget.fieldPartyEntity.activeScheduleSetting?.sessionMinuteInt ?? 60} ${AppLocalizations.of(context)!.minutes}"),
                        SizedBox(width: 12.w),
                        _IconText(
                            svg: 'assets/icons/group.svg',
                            text: "${widget.fieldPartyEntity.personQty}"),
                        SizedBox(width: 12.w),
                        _IconText(
                            svg: 'assets/icons/city.svg',
                            text:
                                "${widget.fieldPartyEntity.field?.city?.titleRu}"),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    Text(AppLocalizations.of(context)!.selectTime,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(height: 8.h),

                    /// 🕒 Расписание
                    BlocProvider.value(
                      value: previewBloc,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F5FA),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: BlocBuilder<FieldPartySchedulePreviewBloc,
                            FieldPartySchedulePreviewState>(
                          builder: (context, state) {
                            if (state is FieldPartySchedulePreviewLoadedState) {
                              if (state.schedulePreview.generatedCount > 0) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      child: DatePicker(
                                        DateTime.now(),
                                        initialSelectedDate: parameter.day,
                                        selectionColor: AppColors.primaryLight,
                                        selectedTextColor: Colors.white,
                                        onDateChange: _onDateChanged,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    DynamicHeightGridView(
                                      builder: (ctx, index) {
                                        final entity = state.schedulePreview
                                            .scheduleRecords[index];
                                        return GestureDetector(
                                          onTap: () =>
                                              _onScheduleSelect(entity),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 10.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: scheduleRecordEntity
                                                          ?.startAt ==
                                                      entity.startAt
                                                  ? AppColors.primaryLight
                                                  : AppColors.grey300,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${entity.startAt} - ${entity.endAt}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: scheduleRecordEntity
                                                                ?.startAt ==
                                                            entity.startAt
                                                        ? AppColors.white
                                                        : AppColors.grey500,
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "${entity.price} KZT",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: scheduleRecordEntity
                                                                ?.startAt ==
                                                            entity.startAt
                                                        ? AppColors.white
                                                        : AppColors.grey500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          state.schedulePreview.generatedCount,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 10.h,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                    ),
                                    (scheduleRecordEntity != null
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${scheduleRecordEntity?.price} KZT",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color:
                                                        const Color(0xFF0247C3),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      Size.fromHeight(45.h),
                                                  backgroundColor:
                                                      AppColors.primary,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.w),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                  ),
                                                ),
                                                onPressed: _handlePayment,
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .pay,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ))
                                            ],
                                          )
                                        : SizedBox())
                                  ],
                                );
                              }
                              return Text(
                                  AppLocalizations.of(context)!.noScheduleYet);
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
