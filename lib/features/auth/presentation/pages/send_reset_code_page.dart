import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/reset_password_bloc/reset_password_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/reset_password_bloc/reset_password_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/constants/form_validation_constants.dart';
import '../../../../core/di/injection.dart';

class SendResetCodePage extends StatefulWidget {
  const SendResetCodePage({super.key});

  @override
  State<SendResetCodePage> createState() => _SendResetCodePageState();
}

class _SendResetCodePageState extends State<SendResetCodePage> {
  final _phoneC = TextEditingController();
  String? _phoneError;

  final _phoneMask = MaskTextInputFormatter(
    mask: '+7 7## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void dispose() {
    _phoneC.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    final text = value ?? _phoneC.text;
    final cleanPhone = text.replaceAll(RegExp(r'\D'), '');

    if (text.isEmpty || cleanPhone.isEmpty) {
      return AppLocalizations.of(context)!.enterPhone;
    }

    if (cleanPhone.length != 11) {
      return AppLocalizations.of(context)!.phoneFormat;
    }

    final re = RegExp(FormValidationConstant.PhoneRegExp);
    if (!re.hasMatch(cleanPhone)) {
      return AppLocalizations.of(context)!.phoneFormat;
    }
    return null;
  }

  String _getCleanPhone() {
    final text = _phoneC.text;
    final cleanPhone = text.replaceAll(RegExp(r'\D'), '');
    return cleanPhone;
  }

  void _submitForm(BuildContext context) {
    final error = _validatePhone(_phoneC.text);

    setState(() {
      _phoneError = error;
    });

    if (error == null) {
      String phone = _getCleanPhone();
      context.read<ResetPasswordBloc>().add(SendResetCodeSubmitted(phone));
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
      body: BlocProvider<ResetPasswordBloc>(
        create: (context) => getIt<ResetPasswordBloc>(),
        child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (BuildContext context, ResetPasswordState state) {
            if (state is SendResetCodeSuccess) {
              if (state.result.result == true) {
                FocusScope.of(context).unfocus();
                final cleanPhone = _getCleanPhone();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.success,
                      message: state.result.message ??
                          'Код для сброса пароля отправлен',
                      contentType: ContentType.success,
                    ),
                  ),
                );
                context.pushNamed(
                  AppRouteConstants.ResetPasswordPageName,
                  queryParameters: {'phone': cleanPhone},
                  extra: state.result,
                );
              } else {
                FocusScope.of(context).unfocus();
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
            } else if (state is ResetPasswordFailure) {
              FocusScope.of(context).unfocus();
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
          builder: (BuildContext context, ResetPasswordState state) {
            final isLoading = state is ResetPasswordLoading;

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
                            // Icon
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.lock_reset_outlined,
                                size: 48.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // Title
                            Text(
                              AppLocalizations.of(context)!.passwordResetTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            // Subtitle
                            Text(
                              AppLocalizations.of(context)!.enterPhoneToGetCode,
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
                                                    .sendCode,
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
                                    'или',
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
                                    AppLocalizations.of(context)!.backToSignIn,
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
