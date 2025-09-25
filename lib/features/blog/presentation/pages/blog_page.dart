import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../domain/parameters/get_news_parameter.dart';
import '../bloc/get_news/get_news_bloc.dart';
import '../bloc/get_news/get_news_event.dart';
import '../bloc/get_news/get_news_state.dart';
import '../widgets/blog_card_widget.dart';
import 'news_detail_page.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  late GetNewsBloc _newsBloc;
  late ScrollController _scrollController;
  int _currentPage = 1;
  final int _perPage = 20;

  // Категории и выбранная категория
  String _selectedCategory = 'KFF';
  NewsPlatform _selectedPlatform = NewsPlatform.yii;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'KFF', 'platform': NewsPlatform.yii},
    {'name': 'KFF League', 'platform': NewsPlatform.laravel},
  ];

  @override
  void initState() {
    super.initState();
    _newsBloc = getIt<GetNewsBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadNews();
  }

  void _loadNews() {
    final params = GetNewsParameter(
      platform: _selectedPlatform,
      page: 1,
      perPage: 20,
    );
    _currentPage = 1;

    // Используем правильное событие в зависимости от платформы
    if (_selectedPlatform == NewsPlatform.yii) {
      _newsBloc.add(GetNewsFromKffEvent(params));
    } else {
      _newsBloc.add(GetNewsFromKffLeagueEvent(params));
    }
  }

  void _loadMoreNews() {
    _currentPage++;
    final params = GetNewsParameter(
      platform: _selectedPlatform,
      page: _currentPage,
      perPage: _perPage,
    );

    // Используем правильное событие для пагинации в зависимости от платформы
    if (_selectedPlatform == NewsPlatform.yii) {
      _newsBloc.add(LoadMoreNewsFromKffEvent(params));
    } else {
      _newsBloc.add(LoadMoreNewsFromKffLeagueEvent(params));
    }
  }

  void _onScroll() {
    if (_isBottom) {
      final currentState = _newsBloc.state;
      if (currentState is GetNewsStateSuccessState &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        _loadMoreNews();
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _newsBloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PagesCommonAppBar(
          title: AppLocalizations.of(context)!.news,
          actionIcon: Icons.notifications_none,
          onActionTap: () {},
        ),
        body: BlocBuilder<GetNewsBloc, GetNewsStateState>(
          builder: (context, state) {
            if (state is GetNewsStateLoadingState) {
              return Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildLoadingState()),
                ],
              );
            } else if (state is GetNewsStateSuccessState) {
              return _buildSuccessState(state);
            } else if (state is GetNewsStateFailedState) {
              return Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildErrorState(state.failureData.message)),
                ],
              );
            }
            return Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildEmptyState()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.latestNews,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          GestureDetector(
            onTap: _showCategorySelector,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCategory,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(GetNewsStateSuccessState state) {
    final newsList = state.newsResponse.data;
    if (newsList.isEmpty) {
      return Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildEmptyState()),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _loadNews(),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= newsList.length) {
                    return _buildLoadingIndicator();
                  }

                  final news = newsList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: NewsCard(
                      imageUrl: news.imageUrl ?? '',
                      tag: news.categoryTitle ??
                          AppLocalizations.of(context)!.news,
                      title: news.title,
                      date: _formatDate(news.date),
                      likes: news.views ?? 0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailPage(
                              newsId: news.id,
                              platform: _selectedPlatform,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: newsList.length + (state.hasReachedMax ? 0 : 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.all(16.h),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildLoadingState() {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      children: List.generate(5, (index) => _buildLoadingCard()),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 90.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 12.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
              AppLocalizations.of(context)!.newsLoadError,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message ?? AppLocalizations.of(context)!.unknownError,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _loadNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gradientStart,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.retry,
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
              AppLocalizations.of(context)!.noNewsYet,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              AppLocalizations.of(context)!.checkLater,
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

  void _showCategorySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                height: 4.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  AppLocalizations.of(context)!.selectCategory,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ..._categories.map((category) {
                return ListTile(
                  title: Text(
                    category['name'],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      fontWeight: _selectedCategory == category['name']
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: _selectedCategory == category['name']
                          ? AppColors.gradientStart
                          : AppColors.textPrimary,
                    ),
                  ),
                  trailing: _selectedCategory == category['name']
                      ? Icon(
                          Icons.check,
                          color: AppColors.gradientStart,
                        )
                      : null,
                  onTap: () {
                    _onCategorySelected(category['name'], category['platform']);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  void _onCategorySelected(String categoryName, NewsPlatform platform) {
    setState(() {
      _selectedCategory = categoryName;
      _selectedPlatform = platform;
    });
    _loadNews();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return AppLocalizations.of(context)!.dateNotSpecified;

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${AppLocalizations.of(context)!.today}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '${AppLocalizations.of(context)!.yesterday}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${AppLocalizations.of(context)!.daysAgo}';
    } else {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }
  }
}
