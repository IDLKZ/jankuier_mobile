import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../l10n/app_localizations.dart';
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
  final _phoneC = TextEditingController();
  String? _phoneError;

  final _phoneMask = MaskTextInputFormatter(
    mask: '+7 7## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    // Pre-fill phone number if provided
    if (widget.phone != null && widget.phone!.isNotEmpty) {
      try {
        // Clean the phone number (remove all non-digits)
        final cleanPhone = widget.phone!.replaceAll(RegExp(r'\D'), '');
        print(cleanPhone);
        if (cleanPhone.startsWith('77') && cleanPhone.length == 11) {
          final digitsOnly = cleanPhone.substring(2);
          _phoneC.text = _phoneMask.maskText(digitsOnly);
        } else {
          // If format doesn't match, leave field empty
        }
      } catch (e) {
        // If formatting fails, leave field empty
      }
    }
  }

  @override
  void dispose() {
    _phoneC.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    // Get text from controller (more reliable than getUnmaskedText when pre-filled)
    final text = value ?? _phoneC.text;
    // Extract only digits - this will include all digits from mask +7 7## ###-##-##
    final cleanPhone = text.replaceAll(RegExp(r'\D'), '');
    // Check if completely empty
    if (text.isEmpty || cleanPhone.isEmpty) {
      return AppLocalizations.of(context)!.enterPhone;
    }
    // cleanPhone should be 11 digits: 77XXXXXXXXX
    if (cleanPhone.length != 11) {
      return AppLocalizations.of(context)!.phoneFormat;
    }
    // Check if phone matches the pattern 77XXXXXXXXX
    final re = RegExp(FormValidationConstant.PhoneRegExp);
    if (!re.hasMatch(cleanPhone)) {
      return AppLocalizations.of(context)!.phoneFormat;
    }
    return null;
  }

  String _getCleanPhone() {
    // Get digits from controller text
    final text = _phoneC.text;
    final cleanPhone = text.replaceAll(RegExp(r'\D'), '');

    // cleanPhone already contains all digits from mask: 77XXXXXXXXX (11 digits)
    return cleanPhone;
  }

  void _submitForm(BuildContext context) {
    final error = _validatePhone(_phoneC.text);

    setState(() {
      _phoneError = error;
    });

    if (error == null) {
      String phone = _getCleanPhone();
      context.read<SendVerifyCodeBloc>().add(SendVerifyCodeSubmitted(phone));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            context.go(AppRouteConstants.SignInPagePath);
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
      body: BlocProvider<SendVerifyCodeBloc>(
        create: (context) => getIt<SendVerifyCodeBloc>(),
        child: BlocConsumer<SendVerifyCodeBloc, SendVerifyCodeState>(
          listener: (BuildContext context, SendVerifyCodeState state) {
            if (state is SendVerifyCodeSuccess) {
              if (state.result.result == true) {
                final cleanPhone = _getCleanPhone();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.success,
                      message: state.result.message ??
                          AppLocalizations.of(context)!
                              .codeVerifiedSuccessfully,
                      contentType: ContentType.success,
                    ),
                  ),
                );
                context.pushNamed(
                  AppRouteConstants.VerifyCodePageName,
                  queryParameters: {'phone': cleanPhone},
                  extra: state.result,
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
                          AppLocalizations.of(context)!.somethingWentWrong,
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
          builder: (BuildContext context, SendVerifyCodeState state) {
            final isLoading = state is SendVerifyCodeLoading;

            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                ),
                Positioned.fill(
                  child: Transform.scale(
                    scale: 1.4,
                    child: Image.asset(
                      "assets/images/circle_vector.png",
                      fit: BoxFit.contain,
                      color: Colors.black.withValues(alpha: 0.2),
                      colorBlendMode: BlendMode.multiply,
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
                            // Logo
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
                                  .enterPhoneForVerification,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            // Subtitle
                            Text(
                              AppLocalizations.of(context)!.weWillSendSmsCode,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 40.h),

                            // Phone Field with Glass Effect
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white.withOpacity(0.15),
                                    border: Border.all(
                                      color: _phoneError != null
                                          ? Colors.yellow[300]!
                                          : Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _phoneC,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [_phoneMask],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      filled: false,
                                      prefixIcon: Icon(
                                        Icons.phone_outlined,
                                        color: Colors.white.withOpacity(0.8),
                                        size: 24.sp,
                                      ),
                                      hintText: AppLocalizations.of(context)!
                                          .enterPhoneHint,
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 18.h,
                                      ),
                                      errorStyle: const TextStyle(height: 0),
                                    ),
                                    onChanged: (_) {
                                      if (_phoneError != null) {
                                        setState(() {
                                          _phoneError = null;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                if (_phoneError != null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      top: 8.h,
                                    ),
                                    child: Text(
                                      _phoneError!,
                                      style: TextStyle(
                                        color: Colors.yellow[300],
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 32.h),

                            // Send Code Button
                            Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                gradient: LinearGradient(
                                  colors: isLoading
                                      ? [Colors.grey[400]!, Colors.grey[500]!]
                                      : [
                                          const Color(0xFFFFC107),
                                          const Color(0xFFFFB300),
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: isLoading
                                    ? []
                                    : [
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
                                  borderRadius: BorderRadius.circular(16.r),
                                  onTap: isLoading
                                      ? null
                                      : () => _submitForm(context),
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.sms_outlined,
                                                color: const Color(0xFF0148C9),
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .sendSMSCode,
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF0148C9),
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

                            // Info card
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white.withOpacity(0.1),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .smsCodeWillArriveIn,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.or,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
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

                            // Back to Sign In
                            TextButton(
                              onPressed: () {
                                context.go(AppRouteConstants.SignInPagePath);
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
                                    AppLocalizations.of(context)!.iHaveAccount,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
