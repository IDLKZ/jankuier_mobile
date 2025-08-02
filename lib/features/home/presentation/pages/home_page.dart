import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../matches/presentation/widgets/matches_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with logo, slogan and notification
            Container(
              height: 160.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0A388C),
                    Color(0xFF004AD0),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/app_bar_element.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h)
                          .copyWith(bottom: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo and slogan
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/logo_white.png'),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Jankuier',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),

                          // Notification icon
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withValues(alpha: 0.2)),
                                child: IconButton(
                                  icon: Icon(Icons.notifications_none,
                                      size: 30,
                                      color: Colors.white.withValues(alpha: 0.7)),
                                  onPressed: () {
                                    // notification action
                                  },
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            // Carousel Slider - positioned to overlap header
            Transform.translate(
              offset: Offset(0, -80.h), // Move up to overlap header
              child: CarouselSlider(
              options: CarouselOptions(
                height: 180.h, // Increased height to accommodate ActiveMatchCard
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.85, // Slightly increased for better visibility
              ),
              items: _buildCarouselItems(),
              ),
            ),
            
            // Additional content for scrolling (moved up to compensate for carousel overlap)
            Transform.translate(
              offset: Offset(0, -120.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    MainTitleWidget(
                      title: 'Последние новости',
                      secondTitle: 'Все новости',
                      secondColor: Colors.black.withOpacity(0.6),
                      secondFontSize: 14,
                    ),
                    SizedBox(height: 15.h),
                    _buildNewsCard(
                      'Чемпионат мира 2025',
                      'Казахстан готовится к важному матчу против Уэльса',
                      'assets/images/news1.jpg',
                      'news_1',
                    ),
                    SizedBox(height: 10.h),
                    _buildNewsCard(
                      'Трансферы',
                      'Новые игроки присоединились к национальной сборной',
                      'assets/images/news2.jpg',
                      'news_2',
                    ),
                    SizedBox(height: 10.h),
                    _buildNewsCard(
                      'Рейтинг FIFA',
                      'Обновленный рейтинг команд на июль 2025',
                      'assets/images/news3.jpg',
                      'news_3',
                    ),
                    SizedBox(height: 100.h), // Extra space for bottom navigation
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCarouselItems() {
    final List<Map<String, dynamic>> carouselData = [
      {
        'title': 'Чемпионат мира 2025',
        'team1Name': 'Казахстан',
        'team2Name': 'Уэльс',
        'team1LogoUrl': 'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
        'team2LogoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
        'score': '0:0',
        'timer': '47:00',
        'isLive': true
      },
      {
        'title': 'Чемпионат мира 2025',
        'team1Name': 'Аргентина',
        'team2Name': 'Бразилия',
        'team1LogoUrl': 'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
        'team2LogoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
        'score': '1:0',
        'timer': '54:23',
        'isLive': true
      },
      {
        'title': 'Чемпионат мира 2025',
        'team1Name': 'Польша',
        'team2Name': 'Австрия',
        'team1LogoUrl': 'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
        'team2LogoUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
        'score': '2:2',
        'timer': '77:15',
        'isLive': true
      },
    ];

    return carouselData.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> item = entry.value;
      return Container(
        key: ValueKey('carousel_item_$index'),
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        height: 180.h, // Fixed height to prevent overflow
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: 320.w, // Fixed width for consistency
            child: ActiveMatchCard(
              title: item['title'],
              team1Name: item['team1Name'],
              team2Name: item['team2Name'],
              team1LogoUrl: item['team1LogoUrl'],
              team2LogoUrl: item['team2LogoUrl'],
              score: item['score'],
              timer: item['timer'],
              isLive: item['isLive'],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildNewsCard(String title, String subtitle, String imagePath, String keyId) {
    return Container(
      key: ValueKey(keyId),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.grey200,
            ),
            child: const Icon(
              Icons.image,
              color: AppColors.grey400,
              size: 30,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}