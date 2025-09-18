import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';

import '../../../../core/constants/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FlutterCarouselController buttonCarouselController =
      FlutterCarouselController();
  int indexPage = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF004AD0), // #004AD0
                Color(0xFF0A388C), // #0A388C
              ],
              begin: Alignment.topLeft, // начало градиента
              end: Alignment.bottomRight, // конец градиента
            ),
          ),
        ),
        Image.asset(
          "assets/images/circle_vector.png", fit: BoxFit.fill,
          // затемнение (опционально)
          colorBlendMode: BlendMode.darken,
        ),
        Positioned(
          top: 40.h,
          left: 25.w,
          child: GestureDetector(
            onTap: () => context.go(AppRouteConstants.SignInPagePath),
            child: Container(
              width: 40, // сделал чуть больше для баланса
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new, // более ровная версия
                  size: 20.sp,
                  color: Color(0xFF0148C9),
                ),
              ),
            ),
          ),
        ),
        SizedBox.expand(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/kff_logo.png", width: 120.w),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Регистрация",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SingleChildScrollView(
                      child: FlutterCarousel(
                        options: FlutterCarouselOptions(
                            height: 320,
                            initialPage: 0,
                            showIndicator: false,
                            viewportFraction: 1,
                            controller: buttonCarouselController,
                            onPageChanged: (int index, func) {
                              setState(() {
                                indexPage = index;
                              });
                            }),
                        items: [1, 2].map((i) {
                          if (i == 1) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: [
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Введите логин',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Введите почту',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Пароль',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Повторите Пароль',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (i == 2) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: [
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Введите фамилию',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Введите имя',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Введите отчество',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Введите номер телефона',
                                      hintStyle:
                                          TextStyle(color: AppColors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox.shrink(); // fallback, если i другое
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          foregroundColor: Color(0xFF0148C9),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (indexPage < 1) {
                            buttonCarouselController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear);
                          }
                        },
                        child: Text(
                          indexPage == 1 ? "Зарегистрировать" : "Далее",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Регистрация
                    TextButton(
                      onPressed: () {
                        context.go(AppRouteConstants.SignInPagePath);
                      },
                      child: Text(
                        'Вход',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    // Поле Email
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
