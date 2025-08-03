import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/features/home/presentation/widgets/best_moments_widget.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../blog/presentation/widgets/blog_card_widget.dart';
import '../../../matches/presentation/widgets/match_result_card.dart';
import '../../../matches/presentation/widgets/matches_card.dart';
import '../../../matches/presentation/widgets/qr_display_dialog.dart';
import '../../../matches/presentation/widgets/ticker_card.dart';
import '../../../services/presentation/widgets/product_card.dart';

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
            SizedBox(
              height: 240.h,
              child: Stack(
                children: [
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
                            padding:
                            EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h)
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
                                              image: AssetImage(
                                                  'assets/images/logo_white.png'),
                                              fit: BoxFit.fill)),
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
                                            color:
                                            Colors.white.withValues(alpha: 0.7)),
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
                    offset: Offset(0, 90.h),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height:
                        180.h, // Increased height to accommodate ActiveMatchCard
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 1, // Slightly increased for better visibility
                      ),
                      items: _buildCarouselItems(),
                    ),
                  )
                ],
              ),
            ),
            // Additional content for scrolling (moved up to compensate for carousel overlap)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  MainTitleWidget(title: 'Ближайшие матчи', secondTitle: 'Все билеты', secondFontSize: 12, secondColor: Colors.black.withValues(alpha: 0.5),),
                  TicketCard(
                    horizontalMargin: 2,
                    league: "Лига чемпионов",
                    dateTime: "29 июля | 23:30",
                    team1Name: "Елимай",
                    team2Name: "Арсенал",
                    team1LogoUrl: "https://upload.wikimedia.org/wikipedia/ru/thumb/4/40/FC_Elimay_Logo.svg/250px-FC_Elimay_Logo.svg.png",
                    team2LogoUrl: "https://upload.wikimedia.org/wikipedia/ru/thumb/5/53/Arsenal_FC.svg/250px-Arsenal_FC.svg.png",
                    onBuyPressed: () {},
                    onMyTicketPressed: () {
                      showModalBottomSheet<void>(
                        useRootNavigator: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 400,
                            color: Colors.white,
                            child: QrDisplayDialog(
                              qrData: "https://example.com/your-ticket-id",
                              onClose: () => Navigator.of(context).pop(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  
                  MainTitleWidget(
                    title: 'Прошедшие матчи',
                    secondTitle: 'Все матчи',
                    secondColor: Colors.black.withValues(alpha: 0.5),
                    secondFontSize: 12,
                  ),
                  const MatchResultCard(
                    horizontalPadding: 6,
                    horizontalMargin: 2,
                    verticalMargin: 12,
                    title: 'Лига чемпионов',
                    team1: 'Елимай',
                    team2: 'Интер',
                    team1LogoUrl: 'https://upload.wikimedia.org/wikipedia/ru/thumb/4/40/FC_Elimay_Logo.svg/250px-FC_Elimay_Logo.svg.png',
                    team2LogoUrl: 'https://upload.wikimedia.org/wikipedia/ru/thumb/9/93/Inter_Miami_CF_logo.png/250px-Inter_Miami_CF_logo.png',
                    score: '4:3',
                    date: '29 июля',
                  ),
                  SizedBox(height: 15.h),
                  MainTitleWidget(
                    title: 'Лучшие моменты',
                    secondTitle: 'Все моменты',
                    secondColor: Colors.black.withValues(alpha: 0.5),
                    secondFontSize: 12,
                  ),
                  SizedBox(height: 15.h),
                  const BestMomentsWidget(images: [
                    "assets/images/best_moments_1.png",
                    "assets/images/best_moments_2.jpg",
                    "assets/images/best_moments_3.png",
                  ]),
                  SizedBox(height: 15.h),
                  MainTitleWidget(
                    title: 'Популярные товары',
                    secondTitle: 'Все товары',
                    secondColor: Colors.black.withValues(alpha: 0.5),
                    secondFontSize: 12,
                  ),
                  const ProductGridCards(
                    itemsCount: 2,
                  ),
                  SizedBox(height: 15.h),
                  MainTitleWidget(
                    title: 'Обсуждение',
                    secondTitle: 'Все новости',
                    secondColor: Colors.black.withValues(alpha: 0.5),
                    secondFontSize: 12,
                    onTap: () {context.push(AppRouteConstants.BlogListPagePath);},
                  ),
                  SizedBox(height: 15.h),
                  NewsCard(
                    imageUrl: 'https://media.istockphoto.com/id/578275372/photo/two-boys-soccer-fans-with-flag-of-kazakhstan-on-t-shirt.webp?s=2048x2048&w=is&k=20&c=CRcBuI4G8LNsj525IWn63NQbuwGaqSKFZeTxaRatH-k=',
                    tag: 'Новости',
                    title: 'МАРАТ ОМАРОВ: «МЫ ОФИЦИАЛЬНО ПОДАЛИ ЗАЯВКУ НА ПРОВЕДЕНИЕ ФИНАЛА ЛИГИ КОНФЕРЕНЦИЙ ИЛИ СУПЕРКУБКА»',
                    date: '14 июля 2025, 15:30',
                    likes: 234,
                    onTap: () {
                      // обработка нажатия
                    },
                  ),
                ],
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
        'team1LogoUrl':
            'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
        'team2LogoUrl':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
        'score': '0:0',
        'timer': '47:00',
        'isLive': true
      },
      {
        'title': 'Чемпионат мира 2025',
        'team1Name': 'Аргентина',
        'team2Name': 'Бразилия',
        'team1LogoUrl':
            'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
        'team2LogoUrl':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
        'score': '1:0',
        'timer': '54:23',
        'isLive': true
      },
      {
        'title': 'Чемпионат мира 2025',
        'team1Name': 'Польша',
        'team2Name': 'Австрия',
        'team1LogoUrl':
            'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
        'team2LogoUrl':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
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

}
