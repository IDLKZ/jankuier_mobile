import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

class FieldCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String size;
  final String duration;
  final String capacity;
  final String price;

  const FieldCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.size,
    required this.duration,
    required this.capacity,
    required this.price,
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
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _IconText(svg: 'assets/icons/field_size.svg', text: size),
              SizedBox(width: 12.w),
              _IconText(svg: 'assets/icons/clock.svg', text: duration),
              SizedBox(width: 12.w),
              _IconText(svg: 'assets/icons/group.svg', text: capacity),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                price,
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
                          initialChildSize: 0.7,
                          maxChildSize: 0.7,
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
                                  title: title,
                                  subtitle: subtitle,
                                  imagePath: imagePath,
                                  size: size,
                                  duration: duration,
                                  capacity: capacity,
                                  times: const [
                                    '17:00',
                                    '18:30',
                                    '20:00',
                                    '21:30',
                                    '23:00'
                                  ],
                                  prices: const [
                                    [
                                      'Занято',
                                      'Занято',
                                      'Занято',
                                      '15000',
                                      '15000'
                                    ],
                                    [
                                      'Занято',
                                      '15000',
                                      '15000',
                                      '15000',
                                      '15000'
                                    ],
                                    [
                                      'Занято',
                                      '15000',
                                      'Занято',
                                      '15000',
                                      '15000'
                                    ],
                                  ],
                                  total: price,
                                  onPay: () => print("Оплата выполнена"),
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
                    "Забронировать",
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
          style: TextStyle(fontSize: 11.sp, color: Color(0xFF838383)),
        ),
      ],
    );
  }
}

class FieldBookingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String size;
  final String duration;
  final String capacity;
  final List<String> times;
  final List<List<String>> prices;
  final String total;
  final VoidCallback onPay;

  const FieldBookingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.size,
    required this.duration,
    required this.capacity,
    required this.times,
    required this.prices,
    required this.total,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ Картинка
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              topLeft: Radius.circular(8.r),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 160.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📋 Заголовок
                Text(title,
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                SizedBox(height: 2.h),
                Text(subtitle,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),

                SizedBox(height: 10.h),
                Row(
                  children: [
                    _IconText(svg: 'assets/icons/field_size.svg', text: size),
                    SizedBox(width: 12.w),
                    _IconText(svg: 'assets/icons/clock.svg', text: duration),
                    SizedBox(width: 12.w),
                    _IconText(svg: 'assets/icons/group.svg', text: capacity),
                  ],
                ),

                SizedBox(height: 16.h),

                // 🕒 Таблица времени
                Text('Выберите время',
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
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
                          ...times.map((t) => Expanded(
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
                      for (int i = 0; i < prices.length; i++)
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
                              ...prices[i].map(
                                (p) => Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: p == 'Занято'
                                          ? Colors.white.withValues(alpha: 0.5)
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        p,
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          color: p == 'Занято'
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
                SizedBox(height: 16.h),

                // 💰 Сумма + Оплата
                Row(
                  children: [
                    Expanded(
                      child: Text('$total ₸',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0149CE), Color(0xFF0A398E)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ElevatedButton(
                          onPressed: onPay,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 30.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Оплатить",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
