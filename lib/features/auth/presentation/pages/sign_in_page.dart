import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
            onTap: () => context.go("/"),
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
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/kff_logo.png", width: 120.w),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Добро пожаловать!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Поле Email
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Электронная почта',
                        hintStyle:
                            TextStyle(color: AppColors.white), // цвет подсказки
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Пароль',
                        hintStyle:
                            TextStyle(color: AppColors.white), // цвет подсказки
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Забыли пароль?",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Кнопка Войти
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          foregroundColor: Color(0xFF0148C9),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Войти',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Регистрация
                    TextButton(
                      onPressed: () {
                        context.go(AppRouteConstants.SignUpPagePath);
                      },
                      child: Text(
                        'Регистрация',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
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
