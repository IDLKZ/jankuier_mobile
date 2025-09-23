import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/constants/form_validation_constants.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/register_parameter.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpBloc>(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  FlutterCarouselController buttonCarouselController = FlutterCarouselController();
  int indexPage = 0;

  // Form keys for each page
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Controllers
  final _usernameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _samePassC = TextEditingController();
  final _firstNameC = TextEditingController();
  final _lastNameC = TextEditingController();
  final _patronomicC = TextEditingController();
  final _phoneC = TextEditingController();

  @override
  void dispose() {
    _usernameC.dispose();
    _emailC.dispose();
    _samePassC.dispose();
    _passC.dispose();
    _firstNameC.dispose();
    _lastNameC.dispose();
    _patronomicC.dispose();
    _phoneC.dispose();
    super.dispose();
  }

  // Validation methods
  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите логин';
    }
    final username = value.trim();
    final re = RegExp(FormValidationConstant.UserNameRegExp);
    if (!re.hasMatch(username)) {
      return 'Логин должен начинаться с буквы и содержать только буквы, цифры и _';
    }
    if (username.length < 3) {
      return 'Логин должен содержать минимум 3 символа';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите email';
    }
    final email = value.trim();
    final re = RegExp(FormValidationConstant.EmailRegExp);
    if (!re.hasMatch(email)) {
      return 'Введите корректный email адрес';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен содержать минимум 6 символов';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Повторите пароль';
    }
    if (value != _passC.text) {
      return 'Пароли не совпадают';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите номер телефона';
    }
    final phone = value.trim();
    final re = RegExp(FormValidationConstant.PhoneRegExp);
    if (!re.hasMatch(phone)) {
      return 'Номер должен начинаться с 7 и содержать 11 цифр (7XXXXXXXXXX)';
    }
    return null;
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите имя';
    }
    if (value.trim().length < 2) {
      return 'Имя должно содержать минимум 2 символа';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите фамилию';
    }
    if (value.trim().length < 2) {
      return 'Фамилия должна содержать минимум 2 символа';
    }
    return null;
  }

  // Navigation methods
  void _nextPage() {
    if (indexPage == 0) {
      if (_formKey1.currentState!.validate()) {
        buttonCarouselController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    if (_formKey2.currentState!.validate()) {
      final registerParameter = RegisterParameter(
        username: _usernameC.text.trim(),
        email: _emailC.text.trim(),
        password: _passC.text,
        firstName: _firstNameC.text.trim(),
        lastName: _lastNameC.text.trim(),
        patronymic: _patronomicC.text.trim().isEmpty ? null : _patronomicC.text.trim(),
        phone: _phoneC.text.trim(),
      );

      context.read<SignUpBloc>().add(SignUpSubmitted(registerParameter));
    }
  }

  // Widget builders
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.white),
        errorStyle: TextStyle(color: Colors.yellow[300]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[300]!, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Form(
      key: _formKey1,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              _buildTextFormField(
                controller: _usernameC,
                hintText: 'Введите логин',
                validator: _validateUsername,
              ),
              SizedBox(height: 16.h),
              _buildTextFormField(
                controller: _emailC,
                hintText: 'Введите почту',
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              _buildTextFormField(
                controller: _passC,
                hintText: 'Пароль',
                validator: _validatePassword,
                obscureText: true,
              ),
              SizedBox(height: 16.h),
              _buildTextFormField(
                controller: _samePassC,
                hintText: 'Повторите пароль',
                validator: _validateConfirmPassword,
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondPage() {
    return Form(
      key: _formKey2,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              _buildTextFormField(
                controller: _lastNameC,
                hintText: 'Введите фамилию',
                validator: _validateLastName,
              ),
              SizedBox(height: 16.h),
              _buildTextFormField(
                controller: _firstNameC,
                hintText: 'Введите имя',
                validator: _validateFirstName,
              ),
              SizedBox(height: 16.h),
              _buildTextFormField(
                controller: _patronomicC,
                hintText: 'Введите отчество (необязательно)',
                validator: (value) => null, // Optional field
              ),
              SizedBox(height: 16.h),
              _buildTextFormField(
                controller: _phoneC,
                hintText: 'Введите номер телефона (7XXXXXXXXXX)',
                validator: _validatePhone,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocListener(
          listeners: [
            BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Регистрация успешна! Пожалуйста, подтвердите номер телефона'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Navigate to EnterPhonePage with phone from UserEntity
                  context.pushNamed(
                    AppRouteConstants.EnterPhonePageName,
                    queryParameters: {'phone': state.user.phone},
                  );
                } else if (state is SignUpFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF004AD0),
                      Color(0xFF0A388C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/circle_vector.png",
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.darken,
              ),
              Positioned(
                top: 40.h,
                left: 25.w,
                child: GestureDetector(
                  onTap: () => context.go(AppRouteConstants.SignInPagePath),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20.sp,
                        color: Color(0xFF0148C9),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Image.asset(
                            "assets/images/kff_logo.png",
                            width: 120.w,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Регистрация",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Page indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: indexPage == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: indexPage == 1 ? Colors.white : Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Form carousel
                          SizedBox(
                            height: 300.h,
                            child: FlutterCarousel(
                              options: FlutterCarouselOptions(
                                height: 300.h,
                                initialPage: 0,
                                showIndicator: false,
                                viewportFraction: 1,
                                controller: buttonCarouselController,
                                onPageChanged: (int index, func) {
                                  setState(() {
                                    indexPage = index;
                                  });
                                },
                              ),
                              items: [
                                _buildFirstPage(),
                                _buildSecondPage(),
                              ],
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Action button
                          BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              final isLoading = state is SignUpLoading;
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow[700],
                                    foregroundColor: Color(0xFF0148C9),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: isLoading ? null : _nextPage,
                                  child: isLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Color(0xFF0148C9),
                                          ),
                                        )
                                      : Text(
                                          indexPage == 1 ? "Зарегистрировать" : "Далее",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Sign in link
                          TextButton(
                            onPressed: () {
                              context.go(AppRouteConstants.SignInPagePath);
                            },
                            child: Text(
                              'Уже есть аккаунт? Войти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}