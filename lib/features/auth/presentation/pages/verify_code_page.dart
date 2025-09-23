import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/user_verification_parameter.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_state.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/verify_code_bloc/verify_code_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/verify_code_bloc/verify_code_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/verify_code_bloc/verify_code_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';

class VerifyCodePage extends StatefulWidget {
  final String phone;
  final UserCodeVerificationResultEntity verificationResult;

  const VerifyCodePage({
    super.key,
    required this.phone,
    required this.verificationResult,
  });

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isCodeComplete = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onCodeChanged(String code) {
    setState(() {
      _isCodeComplete = code.length == 6;
    });

    if (_isCodeComplete) {
      _submitCode(code);
    }
  }

  void _submitCode(String code) {
    final parameter = UserCodeVerificationParameter(
      phone: widget.phone,
      code: code,
    );
    context.read<VerifyCodeBloc>().add(VerifyCodeSubmitted(parameter));
  }

  void _resendCode() {
    context.read<SendVerifyCodeBloc>().add(SendVerifyCodeSubmitted(widget.phone));
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.white),
        color: Colors.transparent,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.white, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: AppColors.white),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<SendVerifyCodeBloc>()),
          BlocProvider(create: (context) => getIt<VerifyCodeBloc>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<SendVerifyCodeBloc, SendVerifyCodeState>(
              listener: (context, state) {
                if (state is SendVerifyCodeSuccess) {
                  if (state.result.result == true) {
                    Fluttertoast.showToast(msg: "Код повторно отправлен");
                  } else {
                    Fluttertoast.showToast(
                        msg: state.result.message ?? "Ошибка отправки кода");
                  }
                } else if (state is SendVerifyCodeFailure) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
            ),
            BlocListener<VerifyCodeBloc, VerifyCodeState>(
              listener: (context, state) {
                if (state is VerifyCodeSuccess) {
                  if (state.result.result == true) {
                    Fluttertoast.showToast(msg: "Код подтвержден успешно!");
                    context.go(AppRouteConstants.HomePagePath);
                  } else {
                    Fluttertoast.showToast(
                        msg: state.result.message ?? "Неверный код");
                  }
                } else if (state is VerifyCodeFailure) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
            ),
          ],
          child: BlocBuilder<VerifyCodeBloc, VerifyCodeState>(
            builder: (context, verifyState) {
              return BlocBuilder<SendVerifyCodeBloc, SendVerifyCodeState>(
                builder: (context, sendState) {
                  final isLoading = verifyState is VerifyCodeLoading ||
                      sendState is SendVerifyCodeLoading;

                  return Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
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
                          onTap: () => context.go(AppRouteConstants.EnterPhonePagePath),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 20.sp,
                                color: const Color(0xFF0148C9),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/kff_logo.png",
                                      width: 120.w,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      "Введите код подтверждения",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Код отправлен на номер ${widget.phone}",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(height: 24.h),

                                    // PIN Input
                                    Pinput(
                                      controller: _codeController,
                                      length: 6,
                                      defaultPinTheme: defaultPinTheme,
                                      focusedPinTheme: focusedPinTheme,
                                      submittedPinTheme: submittedPinTheme,
                                      onChanged: _onCodeChanged,
                                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                      showCursor: true,
                                      cursor: Container(
                                        width: 2,
                                        height: 24,
                                        color: Colors.white,
                                      ),
                                    ),

                                    SizedBox(height: 24.h),

                                    // Countdown Timer
                                    if (widget.verificationResult.expiresInSeconds != null)
                                      SlideCountdown(
                                        duration: Duration(
                                          seconds: widget.verificationResult.expiresInSeconds!,
                                        ),
                                        slideDirection: SlideDirection.down,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        separator: ":",
                                        onDone: () {
                                          Fluttertoast.showToast(
                                            msg: "Время истекло. Запросите новый код",
                                          );
                                        },
                                      ),

                                    SizedBox(height: 16.h),

                                    // Resend Code Button
                                    TextButton(
                                      onPressed: isLoading ? null : _resendCode,
                                      child: Text(
                                        'Отправить код повторно',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 16.h),

                                    // Back to Login
                                    TextButton(
                                      onPressed: () {
                                        context.go(AppRouteConstants.SignInPagePath);
                                      },
                                      child: Text(
                                        'Назад к входу',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Loading Indicator
                      if (isLoading)
                        Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
