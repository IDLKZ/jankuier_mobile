import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/constants/form_validation_constants.dart';
import '../../../../core/di/injection.dart';

class EnterPhonePage extends StatefulWidget {
  final String? phone;
  const EnterPhonePage({super.key, required this.phone});

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneC = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.phone != null && widget.phone!.isNotEmpty) {
      _phoneC.text = widget.phone!;
    }
  }

  @override
  void dispose() {
    _phoneC.dispose();
    super.dispose();
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

  void _submitForm(context) {
    if (_formKey.currentState!.validate()) {
      String phone = _phoneC.text.trim();
      context.read<SendVerifyCodeBloc>().add(SendVerifyCodeSubmitted(phone));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => getIt<SendVerifyCodeBloc>(),
        child: BlocConsumer<SendVerifyCodeBloc, SendVerifyCodeState>(
          listener: (BuildContext context, SendVerifyCodeState state) {
            if (state is SendVerifyCodeSuccess) {
              if (state.result.result == true) {
                // Navigate to VerifyCodePage with phone and verification result
                context.pushNamed(
                  AppRouteConstants.VerifyCodePageName,
                  queryParameters: {'phone': _phoneC.text.trim()},
                  extra: state.result,
                );
              } else {
                Fluttertoast.showToast(
                    msg: state.result.message ?? "Что-то пошло не так");
              }
            } else if (state is SendVerifyCodeFailure) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (BuildContext context, SendVerifyCodeState state) {
            return Stack(children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: SingleChildScrollView(
                      child: Form(
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
                              "Ввод номера телефона для кода подтверждения",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            // Поле Телефон
                            _buildTextFormField(
                              controller: _phoneC,
                              hintText: 'Введите номер телефона (7XXXXXXXXXX)',
                              validator: _validatePhone,
                              keyboardType: TextInputType.phone,
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
                                  'Отправить SMS код',
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
                                'У меня есть аккаунт',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
