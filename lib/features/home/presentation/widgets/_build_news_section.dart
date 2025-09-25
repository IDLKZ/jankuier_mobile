import 'package:flutter/cupertino.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../blog/data/entities/news_entity.dart';
import '../../../blog/domain/parameters/get_news_parameter.dart';
import '../../../blog/presentation/bloc/get_news/get_news_bloc.dart';
import '../../../blog/presentation/bloc/get_news/get_news_state.dart';
import '../../../blog/presentation/pages/news_detail_page.dart';
import 'home_helpers.dart';

Widget buildNewsSection(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.latestNews,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(AppRouteConstants.BlogListPagePath);
                },
                child: Text(
                  AppLocalizations.of(context)!.allNews,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gradientStart,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<GetNewsBloc, GetNewsStateState>(
          builder: (context, state) {
            if (state is GetNewsStateLoadingState) {
              return Container(
                height: 150.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is GetNewsStateSuccessState) {
              if (state.newsResponse.data.isEmpty) {
                return Container(
                  height: 150.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.newsNotFound,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox(
                height: 210.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: state.newsResponse.data.length,
                  itemBuilder: (context, index) {
                    final news = state.newsResponse.data[index];
                    return Container(
                      width: 280.w,
                      margin: EdgeInsets.only(right: 16.w),
                      child: _buildNewsCard(news, context),
                    );
                  },
                ),
              );
            } else if (state is GetNewsStateFailedState) {
              return Container(
                height: 150.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.newsLoadError,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
        SizedBox(height: 20.h),
      ],
    ),
  );
}

Widget _buildNewsCard(News news, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetailPage(
            newsId: news.id,
            platform: NewsPlatform.yii, // На главной странице загружаем только KFF новости
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Container(
              height: 120.h,
              width: double.infinity,
              color: Colors.grey[200],
              child: news.imageUrl != null && news.imageUrl!.isNotEmpty
                  ? Image.network(
                news.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/dummy.jpg',
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                'assets/images/dummy.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      news.title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        formatNewsDate(context, news.date?.toIso8601String() ?? ''),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.visibility,
                        size: 12.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${news.views ?? 0}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}