import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../../l10n/app_localizations.dart';
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
  final UserCodeVerificationResultEntity? verificationResult;

  const VerifyCodePage({
    super.key,
    required this.phone,
    this.verificationResult,
  });

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _codeController = TextEditingController();
  bool _isCodeComplete = false;
  bool _isTimerExpired = false;
  UserCodeVerificationResultEntity? _currentVerificationResult;

  @override
  void initState() {
    super.initState();
    _currentVerificationResult = widget.verificationResult;

    // If no verification result provided, redirect to EnterPhonePage
    if (_currentVerificationResult == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRouteConstants.SignInPagePath);
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onCodeChanged(String code) {
    setState(() {
      _isCodeComplete = code.length == 4;
    });
  }

  String _formatPhoneForDisplay(String phone) {
    // Format: 71234567890 -> +7 (123) 456-78-90
    if (phone.length == 11 && phone.startsWith('7')) {
      return '+7 (${phone.substring(1, 4)}) ${phone.substring(4, 7)}-${phone.substring(7, 9)}-${phone.substring(9, 11)}';
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    // Modern PIN themes with glass-morphism
    final defaultPinTheme = PinTheme(
      width: 64.w,
      height: 64.h,
      textStyle: TextStyle(
        fontSize: 28.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.white.withOpacity(0.2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white.withOpacity(0.25),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            context.go(AppRouteConstants.EnterPhonePagePath);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.h, left: 10.w),
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
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
                    setState(() {
                      _currentVerificationResult = state.result;
                      _isTimerExpired = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: AppLocalizations.of(context)!.success,
                          message: AppLocalizations.of(context)!
                              .codeResentSuccessfully,
                          contentType: ContentType.success,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: AppLocalizations.of(context)!.error,
                          message: state.result.message ??
                              AppLocalizations.of(context)!.codeResendError,
                          contentType: ContentType.failure,
                        ),
                      ),
                    );
                  }
                } else if (state is SendVerifyCodeFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: AppLocalizations.of(context)!.error,
                        message: state.message,
                        contentType: ContentType.failure,
                      ),
                    ),
                  );
                }
              },
            ),
            BlocListener<VerifyCodeBloc, VerifyCodeState>(
              listener: (context, state) {
                if (state is VerifyCodeSuccess) {
                  if (state.result.result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: AppLocalizations.of(context)!.success,
                          message: AppLocalizations.of(context)!
                              .codeVerifiedSuccessfully,
                          contentType: ContentType.success,
                        ),
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      context.go(AppRouteConstants.SignInPagePath);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: AppLocalizations.of(context)!.error,
                          message: state.result.message ??
                              AppLocalizations.of(context)!.invalidCode,
                          contentType: ContentType.failure,
                        ),
                      ),
                    );
                  }
                } else if (state is VerifyCodeFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: AppLocalizations.of(context)!.error,
                        message: state.message,
                        contentType: ContentType.failure,
                      ),
                    ),
                  );
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
                          gradient: AppColors.primaryGradient,
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Image.asset(
                          "assets/images/circle_vector.png",
                          fit: BoxFit.contain,
                          colorBlendMode: BlendMode.darken,
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
                                  // Security Shield Icon
                                  Hero(
                                    tag: 'app_logo',
                                    child: Image.asset(
                                      "assets/images/kff_logo.png",
                                      width: 120.w,
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  // Title
                                  Text(
                                    AppLocalizations.of(context)!
                                        .enterVerificationCode,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12.h),

                                  // Subtitle with phone
                                  Text(
                                    "${AppLocalizations.of(context)!.codeSentToPhone}",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    _formatPhoneForDisplay(widget.phone),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 40.h),

                                  // PIN Input
                                  Pinput(
                                    controller: _codeController,
                                    length: 4,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    onChanged: _onCodeChanged,
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    showCursor: true,
                                    cursor: Container(
                                      width: 2.5,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 32.h),

                                  // Timer Card
                                  if (_currentVerificationResult != null &&
                                      _currentVerificationResult!
                                              .expiresInSeconds !=
                                          null &&
                                      !_isTimerExpired)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 16.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.timer_outlined,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            size: 24.sp,
                                          ),
                                          SizedBox(width: 12.w),
                                          Text(
                                            'Код действителен:',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          SlideCountdown(
                                            key: ValueKey(
                                                _currentVerificationResult!
                                                    .hashCode),
                                            duration: Duration(
                                              seconds:
                                                  _currentVerificationResult!
                                                      .expiresInSeconds!,
                                            ),
                                            slideDirection: SlideDirection.down,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            separator: ":",
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            onDone: () {
                                              setState(() {
                                                _isTimerExpired = true;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  elevation: 0,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content:
                                                      AwesomeSnackbarContent(
                                                    title: AppLocalizations.of(
                                                            context)!
                                                        .verify,
                                                    message: AppLocalizations
                                                            .of(context)!
                                                        .timeExpiredRequestNew,
                                                    contentType:
                                                        ContentType.warning,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                  // Expired message
                                  if (_isTimerExpired)
                                    Container(
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: Colors.orange.withOpacity(0.2),
                                        border: Border.all(
                                          color: Colors.orange.withOpacity(0.4),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.orange[300],
                                            size: 24.sp,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Text(
                                              'Время действия кода истекло',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  SizedBox(height: 32.h),

                                  // Verify Button
                                  if (_isCodeComplete && !_isTimerExpired)
                                    Container(
                                      width: double.infinity,
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFFC107),
                                            Color(0xFFFFB300),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFFC107)
                                                .withOpacity(0.4),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          onTap: isLoading
                                              ? null
                                              : () {
                                                  final parameter =
                                                      UserCodeVerificationParameter(
                                                    phone: widget.phone,
                                                    code: _codeController.text
                                                        .trim(),
                                                  );
                                                  context
                                                      .read<VerifyCodeBloc>()
                                                      .add(VerifyCodeSubmitted(
                                                          parameter));
                                                },
                                          child: Center(
                                            child: isLoading
                                                ? SizedBox(
                                                    height: 24.h,
                                                    width: 24.w,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Color(0xFF0148C9),
                                                      strokeWidth: 3,
                                                    ),
                                                  )
                                                : Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: const Color(
                                                            0xFF0148C9),
                                                        size: 20.sp,
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .verify,
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFF0148C9),
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  SizedBox(height: 24.h),

                                  // Resend Code Button
                                  if (_isTimerExpired)
                                    Container(
                                      width: double.infinity,
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          onTap: isLoading
                                              ? null
                                              : () {
                                                  context
                                                      .read<
                                                          SendVerifyCodeBloc>()
                                                      .add(
                                                          SendVerifyCodeSubmitted(
                                                              widget.phone));
                                                },
                                          child: Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.white,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .resendCode,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  SizedBox(height: 32.h),

                                  // Divider
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Text(
                                          'или',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 24.h),

                                  // Back to Login
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .go(AppRouteConstants.SignInPagePath);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.login_rounded,
                                          color: Colors.white.withOpacity(0.9),
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .backToLogin,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
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
