import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_state.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/constants/form_validation_constants.dart';
import '../../../../core/di/injection.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC = TextEditingController();
  final _passC = TextEditingController();

  @override
  void dispose() {
    _usernameC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final loginParameter = LoginParameter(
        username: _usernameC.text.trim(),
        password: _passC.text,
      );
      context.read<SignInBloc>().add(SignInSubmitted(loginParameter));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<SignInBloc>()),
          BlocProvider(create: (context) => getIt<GetMeBloc>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignInSuccess) {
                  // Trigger GetMe after successful sign-in
                  context.read<GetMeBloc>().add(const LoadUserProfile());
                } else if (state is SignInFailure) {
                  // Check if it's a 403 error (user needs phone verification)
                  if (state.failure?.statusCode == 403) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Требуется подтверждение номера телефона'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    // Navigate to EnterPhonePage - user will need to enter their phone
                    context.pushNamed(AppRouteConstants.EnterPhonePageName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            BlocListener<GetMeBloc, GetMeState>(
              listener: (context, state) {
                if (state is GetMeLoaded) {
                  // Navigate to home after user data is loaded
                  context.go(AppRouteConstants.HomePagePath);
                }
              },
            ),
          ],
          child: Stack(children: [
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
                onTap: () => context.go(AppRouteConstants.HomePagePath),
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
                    child: BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/kff_logo.png",
                                  width: 120.w),
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
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: _usernameC,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: 'Логин',
                                  hintStyle: TextStyle(color: AppColors.white),
                                  // цвет подсказки
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
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty)
                                    return 'Введите username';
                                  final username = v.trim();
                                  final re = RegExp(
                                      FormValidationConstant.UserNameRegExp);
                                  if (!re.hasMatch(username))
                                    return 'Некорректный ';
                                  return null; // ok
                                },
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: _passC,
                                validator: (v) {
                                  if (v == null || v.isEmpty)
                                    return 'Введите пароль';
                                  if (v.length < 3) return 'Минимум 3 символов';
                                  return null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: 'Пароль',
                                  hintStyle: TextStyle(color: AppColors.white),
                                  // цвет подсказки
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
                              SizedBox(height: 8.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Забыли пароль?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
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
                                  onPressed: () => _submitForm(context),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
