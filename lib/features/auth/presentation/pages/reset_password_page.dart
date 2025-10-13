import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/reset_password_bloc/reset_password_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/reset_password_bloc/reset_password_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';
import '../../data/entities/user_reset_entity.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phone;
  final UserCodeResetResultEntity? verificationResult;

  const ResetPasswordPage({
    super.key,
    required this.phone,
    this.verificationResult,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _codeController = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmPasswordC = TextEditingController();

  bool _isCodeComplete = false;
  bool _isTimerExpired = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  UserCodeResetResultEntity? _currentResetResult;

  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _currentResetResult = widget.verificationResult;

    // If no verification result provided, redirect to SendResetCodePage
    if (_currentResetResult == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRouteConstants.SendResetCodePagePath);
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordC.dispose();
    _confirmPasswordC.dispose();
    super.dispose();
  }

  void _onCodeChanged(String code) {
    setState(() {
      _isCodeComplete = code.length == 4;
    });
  }

  String _formatPhoneForDisplay(String phone) {
    if (phone.length == 11 && phone.startsWith('7')) {
      return '+7 (${phone.substring(1, 4)}) ${phone.substring(4, 7)}-${phone.substring(7, 9)}-${phone.substring(9, 11)}';
    }
    return phone;
  }

  String? _validatePassword(String? value) {
    final passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=]).{8,}$';
    final regex = RegExp(passwordPattern);
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMinSixChars;
    }
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordRequirements;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.repeatPassword;
    }
    if (value != _passwordC.text) {
      return AppLocalizations.of(context)!.passwordsNotMatch;
    }
    return null;
  }

  bool _validateForm() {
    final passwordError = _validatePassword(_passwordC.text);
    final confirmPasswordError =
        _validateConfirmPassword(_confirmPasswordC.text);

    setState(() {
      _passwordError = passwordError;
      _confirmPasswordError = confirmPasswordError;
    });

    return passwordError == null && confirmPasswordError == null;
  }

  void _submitForm(BuildContext context) {
    if (!_isCodeComplete) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: AppLocalizations.of(context)!.error,
            message: AppLocalizations.of(context)!.enterCodeFromSms,
            contentType: ContentType.failure,
          ),
        ),
      );
      return;
    }

    if (_validateForm()) {
      context.read<ResetPasswordBloc>().add(
            VerifyResetCodeSubmitted(
              phone: widget.phone,
              code: _codeController.text.trim(),
              newPassword: _passwordC.text,
            ),
          );
    }
  }

  Widget _buildGlassField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? errorText,
    bool obscureText = false,
    bool hasToggle = false,
    VoidCallback? onToggle,
    bool? toggleState,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white.withOpacity(0.15),
            border: Border.all(
              color: errorText != null
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
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: false,
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(0.8),
                size: 24.sp,
              ),
              suffixIcon: hasToggle
                  ? IconButton(
                      icon: Icon(
                        toggleState!
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white.withOpacity(0.8),
                        size: 24.sp,
                      ),
                      onPressed: onToggle,
                    )
                  : null,
              hintText: hintText,
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
              if (errorText != null) {
                setState(() {
                  if (controller == _passwordC) {
                    _passwordError = null;
                  } else if (controller == _confirmPasswordC) {
                    _confirmPasswordError = null;
                  }
                });
              }
            },
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.yellow[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // PIN themes
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

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              context.go(AppRouteConstants.SendResetCodePagePath);
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
                // Resend code success
                if (state.result.result == true) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _currentResetResult = state.result;
                    _isTimerExpired = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: AppLocalizations.of(context)!.success,
                        message: AppLocalizations.of(context)!.codeResentAgain,
                        contentType: ContentType.success,
                      ),
                    ),
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
              } else if (state is VerifyResetCodeSuccess) {
                // Password reset success
                if (state.result.result == true) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: AppLocalizations.of(context)!.success,
                        message: state.result.message ??
                            AppLocalizations.of(context)!
                                .passwordSuccessfullyChanged,
                        contentType: ContentType.success,
                      ),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    context.go(AppRouteConstants.SignInPagePath);
                  });
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
                            AppLocalizations.of(context)!.wrongCodeOrResetError,
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
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Lock Icon
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
                                    Icons.lock_open_outlined,
                                    size: 48.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 32.h),

                                // Title
                                Text(
                                  AppLocalizations.of(context)!
                                      .newPasswordTitle,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 12.h),

                                // Subtitle
                                Text(
                                  AppLocalizations.of(context)!
                                      .enterSmsCodeAndNewPassword,
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 32.h),

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
                                SizedBox(height: 24.h),

                                // Timer Card
                                if (_currentResetResult != null &&
                                    _currentResetResult!.expiresInSeconds !=
                                        null &&
                                    !_isTimerExpired)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 16.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
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
                                          color: Colors.white.withOpacity(0.8),
                                          size: 24.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        SlideCountdown(
                                          key: ValueKey(
                                              _currentResetResult!.hashCode),
                                          duration: Duration(
                                            seconds: _currentResetResult!
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
                                            FocusScope.of(context).unfocus();
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
                                                content: AwesomeSnackbarContent(
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .error,
                                                  message: AppLocalizations.of(
                                                          context)!
                                                      .codeExpiredRequestNew,
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
                                      borderRadius: BorderRadius.circular(16.r),
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
                                            AppLocalizations.of(context)!
                                                .codeExpired,
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

                                // Password fields (only show if not expired)
                                if (!_isTimerExpired) ...[
                                  _buildGlassField(
                                    controller: _passwordC,
                                    hintText:
                                        AppLocalizations.of(context)!.password,
                                    icon: Icons.lock_outline_rounded,
                                    errorText: _passwordError,
                                    obscureText: _obscurePassword,
                                    hasToggle: true,
                                    toggleState: _obscurePassword,
                                    onToggle: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildGlassField(
                                    controller: _confirmPasswordC,
                                    hintText: AppLocalizations.of(context)!
                                        .repeatPassword,
                                    icon: Icons.lock_outline_rounded,
                                    errorText: _confirmPasswordError,
                                    obscureText: _obscureConfirmPassword,
                                    hasToggle: true,
                                    toggleState: _obscureConfirmPassword,
                                    onToggle: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 32.h),
                                ],

                                // Reset Button
                                if (_isCodeComplete && !_isTimerExpired)
                                  Container(
                                    width: double.infinity,
                                    height: 56.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      gradient: LinearGradient(
                                        colors: isLoading
                                            ? [
                                                Colors.grey[400]!,
                                                Colors.grey[500]!
                                              ]
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
                                        borderRadius:
                                            BorderRadius.circular(16.r),
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
                                                          .resetPasswordButton,
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
                                      borderRadius: BorderRadius.circular(16.r),
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
                                                    .read<ResetPasswordBloc>()
                                                    .add(SendResetCodeSubmitted(
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
                                                    .resendCodeAgain,
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
                                            .backToSignIn,
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
