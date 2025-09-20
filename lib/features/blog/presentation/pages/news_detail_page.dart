import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../data/entities/news_entity.dart';
import '../../domain/parameters/get_new_one_parameter.dart';
import '../../domain/parameters/get_news_parameter.dart';
import '../bloc/get_single_new/get_new_bloc.dart';
import '../bloc/get_single_new/get_new_event.dart';
import '../bloc/get_single_new/get_new_state.dart';

class NewsDetailPage extends StatefulWidget {
  final int newsId;
  final NewsPlatform platform;

  const NewsDetailPage({
    super.key,
    required this.newsId,
    required this.platform,
  });

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late GetNewOneBloc _newOneBloc;

  @override
  void initState() {
    super.initState();
    _newOneBloc = getIt<GetNewOneBloc>();
    _loadNewsDetail();
  }

  void _loadNewsDetail() {
    final params = GetNewOneParameter(
      id: widget.newsId,
    );

    if (widget.platform == NewsPlatform.yii) {
      _newOneBloc.add(GetNewOneFromKffEvent(params));
    } else {
      _newOneBloc.add(GetNewOneFromKffLeagueEvent(params));
    }
  }

  @override
  void dispose() {
    _newOneBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _newOneBloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<GetNewOneBloc, GetNewOneStateState>(
          builder: (context, state) {
            if (state is GetNewOneStateLoadingState) {
              return _buildLoadingState();
            } else if (state is GetNewOneStateSuccessState) {
              return _buildSuccessState(state.newsResponse.data);
            } else if (state is GetNewOneStateFailedState) {
              return _buildErrorState(state.failureData.message);
            }
            return _buildEmptyState();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessState(News news) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          expandedHeight: 300.h,
          pinned: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Hero Image
                news.imageUrl != null && news.imageUrl!.isNotEmpty
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
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tag
                if (news.categoryTitle != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      news.categoryTitle!,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Title
                Text(
                  news.title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 16.h),

                // Date and views
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(news.date),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.visibility,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${news.views ?? 0}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Summary (краткое описание)
                if (news.summary != null) ...[
                  Text(
                    news.summary!,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      color: AppColors.textPrimary,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                // Full text content
                if (news.text != null) ...[
                  Html(
                    data: news.text!,
                    style: {
                      "body": Style(
                        fontFamily: 'Inter',
                        fontSize: FontSize(16.sp),
                        color: AppColors.textPrimary,
                        lineHeight: LineHeight(1.6),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "p": Style(
                        fontFamily: 'Inter',
                        fontSize: FontSize(16.sp),
                        color: AppColors.textPrimary,
                        lineHeight: LineHeight(1.6),
                        margin: Margins.only(bottom: 12.h),
                      ),
                      "h1": Style(
                        fontFamily: 'Inter',
                        fontSize: FontSize(24.sp),
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        margin: Margins.only(top: 16.h, bottom: 8.h),
                      ),
                      "h2": Style(
                        fontFamily: 'Inter',
                        fontSize: FontSize(20.sp),
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        margin: Margins.only(top: 14.h, bottom: 6.h),
                      ),
                      "h3": Style(
                        fontFamily: 'Inter',
                        fontSize: FontSize(18.sp),
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        margin: Margins.only(top: 12.h, bottom: 4.h),
                      ),
                      "strong, b": Style(
                        fontWeight: FontWeight.bold,
                      ),
                      "em, i": Style(
                        fontStyle: FontStyle.italic,
                      ),
                      "a": Style(
                        color: AppColors.gradientStart,
                        textDecoration: TextDecoration.underline,
                      ),
                      "ul": Style(
                        margin: Margins.only(left: 16.w, bottom: 8.h),
                      ),
                      "ol": Style(
                        margin: Margins.only(left: 16.w, bottom: 8.h),
                      ),
                      "li": Style(
                        margin: Margins.only(bottom: 4.h),
                      ),
                      "blockquote": Style(
                        margin: Margins.only(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                        padding: HtmlPaddings.only(left: 12.w),
                        border: Border(
                          left: BorderSide(
                            color: AppColors.gradientStart,
                            width: 3.w,
                          ),
                        ),
                        backgroundColor: Colors.grey.withValues(alpha: 0.1),
                      ),
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String? message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: AppColors.error,
            ),
            SizedBox(height: 16.h),
            Text(
              'Ошибка загрузки новости',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message ?? 'Неизвестная ошибка',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gradientStart,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Назад',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article_outlined,
              size: 64.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'Новость не найдена',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Попробуйте позже',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Дата не указана';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Сегодня, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Вчера, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} дн. назад';
    } else {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }
  }
}