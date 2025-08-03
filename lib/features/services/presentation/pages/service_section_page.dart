import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

class ServiceSectionSinglePage extends StatefulWidget {
  const ServiceSectionSinglePage({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 📷 Основной слайдер
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/section_1.jpg"),
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
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 0.2,
                                offset: const Offset(1, 2), // Shadow position
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
                                color: Colors.black.withValues(alpha: 0.1),
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
                _SectionDetailCard(
                  title: 'Футбольная секция Match Astana',
                  description:
                      'Футбольная секция Match Astana на летний сезон ведет набор. Ребенок любит погонять мяч во дворе и помнит имена любимых футболистов? А когда идет трансляция футбольного матча, его невозможно оторвать от телевизора? Детская футбольная школа "Матч Астана" объявляет набор детей в возрасте от 11 до 14 лет!',
                  price: 15000,
                  duration: '90 минут',
                  ageRange: 'до 11–14 лет',
                  times: const ['17:00', '18:30', '20:00', '21:30', '23:00'],
                  prices: const [
                    ['Нет мест', 'Нет мест', 'Нет мест', '15000', '15000'],
                    ['Нет мест', '10/13', '12/13', '10/13', '11/13'],
                    ['Нет мест', 'Нет мест', '12/13', '10/13', '11/13'],
                  ],
                  onAddToCart: () {
                    print("Добавлено в корзину");
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionDetailCard extends StatefulWidget {
  final String title;
  final String description;
  final int price;
  final VoidCallback onAddToCart;
  final String duration;
  final String ageRange;
  final List<String> times;
  final List<List<String>> prices;

  const _SectionDetailCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.onAddToCart,
    required this.duration,
    required this.ageRange,
    required this.times,
    required this.prices,
  });

  @override
  State<_SectionDetailCard> createState() => _SectionDetailCardState();
}

class _SectionDetailCardState extends State<_SectionDetailCard> {
  int selectedSize = 16;
  int selectedColorIndex = 0;

  final List<int> sizes = [16, 18, 20, 22, 24, 26, 28];
  final List<Color> colors = [Colors.blue, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          MainTitleWidget(title: widget.title),
          SizedBox(height: 6.h),

          /// Description
          Text(
            widget.description,
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
              Text(widget.duration,
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF838383))),
              SizedBox(width: 12.w),
              Icon(Icons.person, size: 14.sp, color: Color(0xFF838383)),
              SizedBox(width: 4.w),
              Text(widget.ageRange,
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF838383))),
            ],
          ),
          SizedBox(height: 12.h),
          // 🕒 Таблица времени
          Text('Выберите время',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5FA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Время
                Row(
                  children: [
                    const SizedBox(width: 28),
                    ...widget.times.map((t) => Expanded(
                          child: Center(
                              child: Text(
                            t,
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF838383),
                                fontWeight: FontWeight.w500),
                          )),
                        )),
                  ],
                ),
                SizedBox(height: 8.h),
                // Ряды слотов
                for (int i = 0; i < widget.prices.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text('№${i + 1}',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF838383))),
                        ),
                        ...widget.prices[i].map(
                          (p) => Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              padding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: p == 'Нет мест' || p == "Нет мест"
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  p,
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    color: p == 'Нет мест' || p == "Нет мест"
                                        ? const Color(0xFF838383)
                                        : const Color(0xFF838383),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
          SizedBox(height: 12.h),

          /// Colors
          const MainTitleWidget(title: "Стоимость"),
          SizedBox(height: 6.h),

          /// Description
          Text(
            '${widget.price} тг/месяц',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF7D7D7E),
            ),
          ),
          SizedBox(height: 24.h),

          /// Price and Button
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Записаться на пробный урок",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
