import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/get_full_academy_entity.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_full_academy_detail/get_full_academy_detail_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_full_academy_detail/get_full_academy_detail_state.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../core/di/injection.dart';
import '../../data/entities/academy/academy_group_entity.dart';
import '../../data/entities/academy/academy_group_schedule_entity.dart';
import '../../domain/parameters/academy_group_schedule_by_day_parameter.dart';
import '../../domain/use_cases/academy/get_academy_group_schedule_case.dart';
import '../bloc/academy_group_schedule/academy_group_schedule_bloc.dart';
import '../bloc/academy_group_schedule/academy_group_schedule_event.dart';
import '../bloc/academy_group_schedule/academy_group_schedule_state.dart';

class ServiceSectionSinglePage extends StatefulWidget {
  final int academyId;

  const ServiceSectionSinglePage({super.key, required this.academyId});

  @override
  State<ServiceSectionSinglePage> createState() =>
      _ServiceSectionSinglePageState();
}

class _ServiceSectionSinglePageState extends State<ServiceSectionSinglePage> {
  bool isFavorite = false;

  final CarouselSliderController _mainCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<GetFullAcademyDetailBloc, GetFullAcademyDetailState>(
        builder: (context, state) {
          if (state is GetFullAcademyDetailLoadedState) {
            GetFullAcademyEntity fullAcademyEntity = state.academy;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // 📷 Основной слайдер
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: fullAcademyEntity.academy.image != null
                                ? NetworkImage(
                                    ApiConstant.GetImageUrl(
                                      fullAcademyEntity.academy.image!.filePath,
                                    ),
                                  ) as ImageProvider
                                : const AssetImage(FileUtils.LocalProductImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 20.w,
                        right: 20.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 0.2,
                                      offset:
                                          const Offset(1, 2), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: const Color(0xFF0444B7),
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              child: Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 0.2,
                                      offset: Offset(1, 2), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    isFavorite == true
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: const Color(0xFFEE120B),
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // 🔽 Мини-превью (thumbnails)
                  Column(
                    children: [
                      BlocProvider(
                        create: (context) => getIt<AcademyGroupScheduleBloc>(),
                        child: _SectionDetailCard(
                          entity: fullAcademyEntity,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _SectionDetailCard extends StatefulWidget {
  final GetFullAcademyEntity entity;
  const _SectionDetailCard({
    super.key,
    required this.entity,
  });

  @override
  State<_SectionDetailCard> createState() => _SectionDetailCardState();
}

class _SectionDetailCardState extends State<_SectionDetailCard> {
  AcademyGroupScheduleByDayParameter? parameter;

  @override
  void initState() {
    super.initState();

    if (widget.entity.groups.isNotEmpty) {
      parameter = AcademyGroupScheduleByDayParameter(
        day: DateTime.now(),
        groupIds: widget.entity.groups.map((item) => item.id).toList(),
      );

      // Инициализируем bloc с начальными данными
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (parameter != null && mounted) {
          context
              .read<AcademyGroupScheduleBloc>()
              .add(GetAcademyGroupScheduleEvent(parameter!));
        }
      });
    }
  }

  void _onDateChange(DateTime date) {
    if (parameter != null) {
      setState(() {
        parameter = parameter!.copyWith(day: date); // копия с новой датой
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            widget.entity.academy.titleRu,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6.h),

          /// Description
          Text(
            "${widget.entity.academy.descriptionRu}",
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF7D7D7E),
            ),
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Icon(Icons.access_time, size: 14.sp, color: Color(0xFF838383)),
              SizedBox(width: 4.w),
              Text(
                  "${widget.entity.academy.averageTrainingTimeInMinute} ${AppLocalizations.of(context)!.minutes}",
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF838383))),
              SizedBox(width: 12.w),
              Icon(Icons.person, size: 14.sp, color: Color(0xFF838383)),
              SizedBox(width: 4.w),
              Text(
                  "${widget.entity.academy.minAge} - ${widget.entity.academy.maxAge} ${AppLocalizations.of(context)!.years}",
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF838383))),
            ],
          ),
          SizedBox(height: 12.h),
          if (parameter != null)
            Column(
              children: [
                MainTitleWidget(title: AppLocalizations.of(context)!.schedule),
                SizedBox(height: 6.h),
                SizedBox(
                  height: 90,
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primaryLight,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      setState(() {
                        parameter = parameter!.copyWith(day: date);
                      });
                      context
                          .read<AcademyGroupScheduleBloc>()
                          .add(GetAcademyGroupScheduleEvent(parameter!));
                    },
                  ),
                ),
                BlocBuilder<AcademyGroupScheduleBloc,
                    AcademyGroupScheduleState>(builder: (context, state) {
                  if (state is AcademyGroupScheduleLoadedState) {
                    if (state.schedules.isNotEmpty) {
                      return Column(
                        children: state.schedules
                            .map((item) =>
                                AcademyGroupScheduleCard(schedule: item))
                            .toList(),
                      );
                    }
                    return Container(
                      margin: EdgeInsetsGeometry.symmetric(vertical: 10.h),
                      child: Text(
                        AppLocalizations.of(context)!.noScheduleYet,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.warning,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                })
              ],
            ),
          Divider(
            height: 15.h,
            color: AppColors.grey200,
          ),
          MainTitleWidget(title: AppLocalizations.of(context)!.groups),
          SizedBox(height: 8.h),
          Column(
            children: widget.entity.groups
                .map((item) => AcademyGroupCard(group: item))
                .toList(),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

class AcademyGroupCard extends StatelessWidget {
  final AcademyGroupEntity group;

  const AcademyGroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final totalPlaces = group.bookedSpace + group.freeSpace;
    final progress = totalPlaces > 0 ? group.bookedSpace / totalPlaces : 0.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Верхняя строка: возраст + статус
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "${group.minAge}-${group.maxAge}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
              const Spacer(),
              group.isRecruiting
                  ? Icon(Icons.check_circle,
                      color: AppColors.success, size: 16.sp)
                  : Icon(Icons.cancel_outlined,
                      color: AppColors.error, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                group.isRecruiting
                    ? AppLocalizations.of(context)!.recruitmentOpen
                    : AppLocalizations.of(context)!.recruitmentClosed,
                style: TextStyle(
                  color: group.isRecruiting ? Colors.green : Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // 🔹 Название группы
          Text(
            group.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),

          // 🔹 Краткое описание
          if (group.descriptionRu != null)
            Text(
              group.descriptionRu!,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),

          SizedBox(height: 8.h),

          // 🔹 Цена
          Row(
            children: [
              Text(
                group.price != null
                    ? "${group.price?.toStringAsFixed(0)} ₸/${group.pricePerRu ?? AppLocalizations.of(context)!.month}"
                    : AppLocalizations.of(context)!.free,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // 🔹 Нижняя инфа: количество мест и время тренировки
          Row(
            children: [
              Icon(Icons.group, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                "${group.bookedSpace}/${totalPlaces}",
                style: TextStyle(fontSize: 12.sp, color: Colors.black87),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                "${group.averageTrainingTimeInMinute ?? 60} ${AppLocalizations.of(context)!.minutes}",
                style: TextStyle(fontSize: 12.sp, color: Colors.black87),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // 🔹 Прогресс бар (занятые места)
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: Colors.grey[300],
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

class AcademyGroupScheduleCard extends StatelessWidget {
  final AcademyGroupScheduleEntity schedule;

  const AcademyGroupScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final group = schedule.group;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Центральная часть
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Время
                Text(
                  "${schedule.startAt.substring(0, 5)} - ${schedule.endAt.substring(0, 5)}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                // Название + возраст
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${group?.name ?? "Группа"}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                // Подзаголовок
                if (group?.localizedDescription(context) != null)
                  Text(
                    group!.localizedDescription(context),
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),

                SizedBox(height: 6.h),

                // Ученики + поле + длительность
                Row(
                  children: [
                    Icon(Icons.group, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 3.w),
                    Text(
                        "${group?.bookedSpace ?? 0} ${AppLocalizations.of(context)!.students}",
                        style:
                            TextStyle(fontSize: 12.sp, color: Colors.black87)),
                    SizedBox(width: 12.w),
                    Icon(Icons.location_on, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 3.w),
                    Text(
                        "${group?.averageTrainingTimeInMinute ?? 60} ${AppLocalizations.of(context)!.minutes}",
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey[700])),
                  ],
                ),
              ],
            ),
          ),
          // 🔹 Статус
        ],
      ),
    );
  }
}
