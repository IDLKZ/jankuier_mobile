import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_state.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/constants/form_validation_constants.dart';
import '../../../../core/di/injection.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

enum InputType { phone, email, username, unknown }

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC = TextEditingController();
  final _passC = TextEditingController();
  bool _obscurePassword = true;

  // Validation error messages
  String? _usernameError;
  String? _passwordError;

  // Phone mask formatter
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Current input type
  InputType _currentInputType = InputType.unknown;

  @override
  void initState() {
    super.initState();
    _usernameC.addListener(_onUsernameChanged);
  }

  @override
  void dispose() {
    _usernameC.removeListener(_onUsernameChanged);
    _usernameC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    setState(() {
      _currentInputType = _detectInputType(_usernameC.text);
    });
  }

  InputType _detectInputType(String input) {
    if (input.isEmpty) return InputType.unknown;

    // Check if starts with + or 7 (phone)
    if (input.startsWith('+') ||
        input.startsWith('7') ||
        RegExp(r'^\+?7').hasMatch(input)) {
      return InputType.phone;
    }

    // Check if contains @ (email)
    if (input.contains('@')) {
      return InputType.email;
    }

    // Otherwise username
    return InputType.username;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterUsername;
    }

    final trimmed = value.trim();
    final type = _detectInputType(trimmed);

    switch (type) {
      case InputType.phone:
        // Remove mask characters for validation
        final digitsOnly = trimmed.replaceAll(RegExp(r'[^\d]'), '');
        if (!RegExp(FormValidationConstant.PhoneRegExp).hasMatch(digitsOnly)) {
          return AppLocalizations.of(context)!.enterValidPhoneNumber;
        }
        break;
      case InputType.email:
        if (!RegExp(FormValidationConstant.EmailRegExp).hasMatch(trimmed)) {
          return AppLocalizations.of(context)!.enterValidEmail;
        }
        break;
      case InputType.username:
        if (!RegExp(FormValidationConstant.UserNameRegExp).hasMatch(trimmed)) {
          return AppLocalizations.of(context)!.incorrectFormat;
        }
        break;
      case InputType.unknown:
        return AppLocalizations.of(context)!.enterEmailPhoneOrLogin;
    }

    return null;
  }

  void _submitForm(BuildContext context) {
    // Clear previous errors
    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    // Validate
    final usernameError = _validateUsername(_usernameC.text);
    final passwordError = _validatePassword(_passC.text);

    if (usernameError != null || passwordError != null) {
      setState(() {
        _usernameError = usernameError;
        _passwordError = passwordError;
      });
      return;
    }

    // Prepare username based on input type
    String username = _usernameC.text.trim();
    if (_currentInputType == InputType.phone) {
      // Remove all non-digit characters from phone
      username = username.replaceAll(RegExp(r'[^\d]'), '');
    }

    final loginParameter = LoginParameter(
      username: username,
      password: _passC.text,
    );
    context.read<SignInBloc>().add(SignInSubmitted(loginParameter));
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (value.length < 3) {
      return AppLocalizations.of(context)!.minimumThreeChars;
    }
    return null;
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
            context.go(AppRouteConstants.HomePagePath);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.h, left: 10.w),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2)),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ),
      ),
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
                  if (state.failure?.statusCode == 403) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: AppLocalizations.of(context)!
                              .enterVerificationCode,
                          message: AppLocalizations.of(context)!
                              .phoneVerificationRequired,
                          contentType: ContentType.warning,
                        ),
                      ),
                    );
                    // Navigate to EnterPhonePage - user will need to enter their phone
                    context.pushNamed(AppRouteConstants.EnterPhonePageName);
                  } else {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: AppLocalizations.of(context)!.errorOccurred,
                          message: "${state.failure?.message}",
                          contentType: ContentType.failure,
                        ),
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
                    child: BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logo with subtle animation
                                Hero(
                                  tag: 'app_logo',
                                  child: Image.asset(
                                    "assets/images/kff_logo.png",
                                    width: 150.w,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  AppLocalizations.of(context)!.welcome,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  AppLocalizations.of(context)!.signIn,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // Welcome Text
                                SizedBox(height: 20.h),
                                // Username Field with Glass Effect
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: Colors.white.withOpacity(0.15),
                                        border: Border.all(
                                          color: _usernameError != null
                                              ? Colors.yellow[300]!
                                              : Colors.white.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        controller: _usernameC,
                                        keyboardType:
                                            _currentInputType == InputType.phone
                                                ? TextInputType.phone
                                                : _currentInputType ==
                                                        InputType.email
                                                    ? TextInputType.emailAddress
                                                    : TextInputType.text,
                                        inputFormatters:
                                            _currentInputType == InputType.phone
                                                ? [_phoneMaskFormatter]
                                                : [],
                                        decoration: InputDecoration(
                                          filled: false,
                                          prefixIcon: Icon(
                                            _currentInputType == InputType.phone
                                                ? Icons.phone_outlined
                                                : _currentInputType ==
                                                        InputType.email
                                                    ? Icons.email_outlined
                                                    : Icons
                                                        .person_outline_rounded,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            size: 24.sp,
                                          ),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .emailPhoneOrLogin,
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 18.h,
                                          ),
                                          errorStyle:
                                              const TextStyle(height: 0),
                                        ),
                                        validator: (_) =>
                                            null, // We handle validation manually
                                      ),
                                    ),
                                    if (_usernameError != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.w,
                                          top: 8.h,
                                        ),
                                        child: Text(
                                          _usernameError!,
                                          style: TextStyle(
                                            color: Colors.yellow[300],
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 20.h),

                                // Password Field with Glass Effect
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: Colors.white.withOpacity(0.15),
                                        border: Border.all(
                                          color: _passwordError != null
                                              ? Colors.yellow[300]!
                                              : Colors.white.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        obscureText: _obscurePassword,
                                        controller: _passC,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration: InputDecoration(
                                          filled: false,
                                          prefixIcon: Icon(
                                            Icons.lock_outline_rounded,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            size: 24.sp,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              size: 24.sp,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .password,
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 18.h,
                                          ),
                                          errorStyle:
                                              const TextStyle(height: 0),
                                        ),
                                        validator: (_) =>
                                            null, // We handle validation manually
                                      ),
                                    ),
                                    if (_passwordError != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.w,
                                          top: 8.h,
                                        ),
                                        child: Text(
                                          _passwordError!,
                                          style: TextStyle(
                                            color: Colors.yellow[300],
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 16.h),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      context.push(AppRouteConstants
                                          .SendResetCodePagePath);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .forgotPassword,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24.h),

                                // Sign In Button with Modern Design
                                Container(
                                  width: double.infinity,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    gradient: LinearGradient(
                                      colors: state is SignInLoading
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
                                    boxShadow: state is SignInLoading
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
                                      onTap: state is SignInLoading
                                          ? null
                                          : () => _submitForm(context),
                                      child: Center(
                                        child: state is SignInLoading
                                            ? SizedBox(
                                                height: 24.h,
                                                width: 24.w,
                                                child:
                                                    const CircularProgressIndicator(
                                                  color: Color(0xFF0148C9),
                                                  strokeWidth: 3,
                                                ),
                                              )
                                            : Text(
                                                AppLocalizations.of(context)!
                                                    .signIn,
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF0148C9),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 32.h),

                                // Divider with "or"
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

                                // Registration Button
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
                                      borderRadius: BorderRadius.circular(16.r),
                                      onTap: () {
                                        context.go(
                                            AppRouteConstants.SignUpPagePath);
                                      },
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .registration,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),

                                // Go to Verification
                                TextButton(
                                  onPressed: () {
                                    context.go(
                                        AppRouteConstants.EnterPhonePagePath);
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
                                        Icons.phone_android_rounded,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .goVerification,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
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
