import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

class ServiceProductPage extends StatefulWidget {
  const ServiceProductPage({super.key});

  @override
  State<ServiceProductPage> createState() => _ServiceProductPageState();
}

class _ServiceProductPageState extends State<ServiceProductPage> {
  bool isFavorite = false;
  final List<String> images = [
    "assets/images/product_1.png",
    "assets/images/product_2.jpg",
    "assets/images/product_3.jpg",
    "assets/images/product_4.jpg",
    "assets/images/product_5.jpg",
  ];

  int _currentIndex = 0;
  final CarouselSliderController _mainCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 📷 Основной слайдер
            Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: _mainCarouselController,
                  itemCount: images.length,
                  itemBuilder: (context, index, _) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 400.h,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
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
                                offset: Offset(1, 2), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF0444B7),
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
                              color: Color(0xFFEE120B),
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
            SizedBox(height: 10.h),
            // 🔽 Мини-превью (thumbnails)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                height: 60.w, // фиксируем высоту
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final isSelected = _currentIndex == index;
                    return GestureDetector(
                      onTap: () {
                        _mainCarouselController.animateToPage(index);
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.w,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            _ProductDetailCard(
              title: 'Футболка “Сборная Казахстана”',
              description:
                  'Официальная форма сборной Казахстана. Выполнена из лёгкого дышащего материала, идеально подходит для тренировок и повседневной носки. Современный дизайн с элементами национального стиля подчёркивает командный дух и гордость за страну.',
              price: 9900,
              onAddToCart: () {
                print("Добавлено в корзину");
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ProductDetailCard extends StatefulWidget {
  final String title;
  final String description;
  final int price;
  final VoidCallback onAddToCart;

  const _ProductDetailCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.onAddToCart,
  });

  @override
  State<_ProductDetailCard> createState() => _ProductDetailCardState();
}

class _ProductDetailCardState extends State<_ProductDetailCard> {
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
              color: Color(0xFF7D7D7E),
            ),
          ),
          SizedBox(height: 16.h),

          /// Sizes
          MainTitleWidget(title: "Размеры"),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: sizes.map((size) {
              final isSelected = selectedSize == size;
              return GestureDetector(
                onTap: () => setState(() => selectedSize = size),
                child: Container(
                  width: 35.w,
                  height: 35.w,
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Color(0xFF7D7D7E),
                      width: 1.5,
                    ),
                    color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                  ),
                  child: Text(
                    "$size",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? Colors.blue : Color(0xFF7D7D7E),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20.h),

          /// Colors
          MainTitleWidget(title: "Цвет"),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(colors.length, (i) {
              final selected = selectedColorIndex == i;
              return GestureDetector(
                onTap: () => setState(() => selectedColorIndex = i),
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors[i],
                    border: Border.all(
                      color: selected ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 24.h),

          /// Price and Button
          Row(
            children: [
              Text(
                '${widget.price.toStringAsFixed(2)} ₸',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0247C3),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Добавить в корзину",
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
