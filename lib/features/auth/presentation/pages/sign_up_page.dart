import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../l10n/app_localizations.dart';
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
  FlutterCarouselController buttonCarouselController =
      FlutterCarouselController();
  int indexPage = 0;

  // Controllers
  final _usernameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _samePassC = TextEditingController();
  final _firstNameC = TextEditingController();
  final _lastNameC = TextEditingController();
  final _patronomicC = TextEditingController();
  final _phoneC = TextEditingController();

  final _phoneMask = MaskTextInputFormatter(
    mask: '+7 7## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Validation errors
  final Map<String, String?> _errors = {};

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
      return AppLocalizations.of(context)!.enterLoginHint;
    }
    final username = value.trim();
    final re = RegExp(FormValidationConstant.UserNameRegExp);
    if (!re.hasMatch(username)) {
      return AppLocalizations.of(context)!.usernameValidation;
    }
    if (username.length < 3) {
      return AppLocalizations.of(context)!.usernameMinChars;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    }
    final email = value.trim();
    final re = RegExp(FormValidationConstant.EmailRegExp);
    if (!re.hasMatch(email)) {
      return AppLocalizations.of(context)!.enterCorrectEmail;
    }
    return null;
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
    if (value != _passC.text) {
      return AppLocalizations.of(context)!.passwordsNotMatch;
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterPhone;
    }
    // Extract all digits from the text field
    final cleanPhone = _phoneC.text.replaceAll(RegExp(r'\D'), '');
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
    // Extract all digits from the text field
    final cleanPhone = _phoneC.text.replaceAll(RegExp(r'\D'), '');
    // cleanPhone already contains all digits from mask: 77XXXXXXXXX (11 digits)
    return cleanPhone;
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterFirstName;
    }
    if (value.trim().length < 2) {
      return AppLocalizations.of(context)!.firstNameMinChars;
    }
    if (value.trim().length > 200) {
      return 'Имя не должно превышать 200 символов';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterLastName;
    }
    if (value.trim().length < 2) {
      return AppLocalizations.of(context)!.lastNameMinChars;
    }
    if (value.trim().length > 200) {
      return 'Фамилия не должна превышать 200 символов';
    }
    return null;
  }

  String? _validatePatronymic(String? value) {
    if (value != null && value.trim().isNotEmpty && value.trim().length > 200) {
      return 'Отчество не должно превышать 200 символов';
    }
    return null;
  }

  // Page 1: ФИО (Фамилия, Имя, Отчество)
  bool _validatePage1() {
    setState(() {
      _errors.clear();
      _errors['lastName'] = _validateLastName(_lastNameC.text);
      _errors['firstName'] = _validateFirstName(_firstNameC.text);
      _errors['patronymic'] = _validatePatronymic(_patronomicC.text);
    });

    return !_errors.values.any((error) => error != null);
  }

  // Page 2: Телефон, Почта, Логин
  bool _validatePage2() {
    setState(() {
      _errors.clear();
      _errors['phone'] = _validatePhone(_phoneC.text);
      _errors['email'] = _validateEmail(_emailC.text);
      _errors['username'] = _validateUsername(_usernameC.text);
    });

    return !_errors.values.any((error) => error != null);
  }

  // Page 3: Пароль и Повторите пароль
  bool _validatePage3() {
    setState(() {
      _errors.clear();
      _errors['password'] = _validatePassword(_passC.text);
      _errors['confirmPassword'] = _validateConfirmPassword(_samePassC.text);
    });

    return !_errors.values.any((error) => error != null);
  }

  void _nextPage() {
    if (indexPage == 0) {
      if (_validatePage1()) {
        buttonCarouselController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (indexPage == 1) {
      if (_validatePage2()) {
        buttonCarouselController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    // Validate all pages first
    final page1Valid = _validatePage1();
    final page2Valid = _validatePage2();
    final page3Valid = _validatePage3();

    // If page 1 has errors, navigate to page 1
    if (!page1Valid) {
      buttonCarouselController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // If page 2 has errors, navigate to page 2
    if (!page2Valid) {
      buttonCarouselController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // If page 3 has errors, stay on page 3
    if (!page3Valid) {
      return;
    }

    // All validation passed, submit the form
    final registerParameter = RegisterParameter(
      username: _usernameC.text.trim(),
      email: _emailC.text.trim(),
      password: _passC.text,
      firstName: _firstNameC.text.trim(),
      lastName: _lastNameC.text.trim(),
      patronymic:
          _patronomicC.text.trim().isEmpty ? null : _patronomicC.text.trim(),
      phone: _getCleanPhone(),
    );

    context.read<SignUpBloc>().add(SignUpSubmitted(registerParameter));
  }

  Widget _buildGlassField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String errorKey,
    bool obscureText = false,
    bool hasToggle = false,
    VoidCallback? onToggle,
    bool? toggleState,
    TextInputType keyboardType = TextInputType.text,
    List<MaskTextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white.withOpacity(0.15),
            border: Border.all(
              color: _errors[errorKey] != null
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
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
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
          ),
        ),
        if (_errors[errorKey] != null)
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h),
            child: Text(
              _errors[errorKey]!,
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

  // Page 1: ФИО (Фамилия, Имя, Отчество)
  Widget _buildFirstPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            _buildGlassField(
              controller: _lastNameC,
              hintText: AppLocalizations.of(context)!.enterLastName,
              icon: Icons.badge_outlined,
              errorKey: 'lastName',
            ),
            SizedBox(height: 20.h),
            _buildGlassField(
              controller: _firstNameC,
              hintText: AppLocalizations.of(context)!.enterFirstName,
              icon: Icons.badge_outlined,
              errorKey: 'firstName',
            ),
            SizedBox(height: 20.h),
            _buildGlassField(
              controller: _patronomicC,
              hintText: AppLocalizations.of(context)!.enterPatronymic,
              icon: Icons.badge_outlined,
              errorKey: 'patronymic',
            ),
          ],
        ),
      ),
    );
  }

  // Page 2: Телефон, Почта, Логин
  Widget _buildSecondPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            _buildGlassField(
              controller: _phoneC,
              hintText: AppLocalizations.of(context)!.enterPhoneHint,
              icon: Icons.phone_outlined,
              errorKey: 'phone',
              keyboardType: TextInputType.phone,
              inputFormatters: [_phoneMask],
            ),
            SizedBox(height: 20.h),
            _buildGlassField(
              controller: _emailC,
              hintText: AppLocalizations.of(context)!.enterEmailHint,
              icon: Icons.email_outlined,
              errorKey: 'email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            _buildGlassField(
              controller: _usernameC,
              hintText: AppLocalizations.of(context)!.enterLoginHint,
              icon: Icons.person_outline_rounded,
              errorKey: 'username',
            ),
          ],
        ),
      ),
    );
  }

  // Page 3: Пароль и Повторите пароль
  Widget _buildThirdPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            _buildGlassField(
              controller: _passC,
              hintText: AppLocalizations.of(context)!.password,
              icon: Icons.lock_outline_rounded,
              errorKey: 'password',
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
              controller: _samePassC,
              hintText: AppLocalizations.of(context)!.repeatPassword,
              icon: Icons.lock_outline_rounded,
              errorKey: 'confirmPassword',
              obscureText: _obscureConfirmPassword,
              hasToggle: true,
              toggleState: _obscureConfirmPassword,
              onToggle: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              if (indexPage > 0) {
                buttonCarouselController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                context.go(AppRouteConstants.SignInPagePath);
              }
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
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: AppLocalizations.of(context)!.success,
                        message:
                            AppLocalizations.of(context)!.registrationSuccess,
                        contentType: ContentType.success,
                      ),
                    ),
                  );
                  context.pushNamed(
                    AppRouteConstants.EnterPhonePageName,
                    queryParameters: {'phone': state.user.phone},
                  );
                } else if (state is SignUpFailure) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: AppLocalizations.of(context)!.errorOccurred,
                        message: state.message,
                        contentType: ContentType.failure,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: Stack(
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
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          // Logo
                          Hero(
                            tag: 'app_logo',
                            child: Image.asset(
                              "assets/images/kff_logo.png",
                              width: 120.w,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // Title
                          Text(
                            AppLocalizations.of(context)!.registration,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppLocalizations.of(context)!.createNewAccount,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 24.h),

                          // Page indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildPageIndicator(0),
                              SizedBox(width: 12.w),
                              _buildPageIndicator(1),
                              SizedBox(width: 12.w),
                              _buildPageIndicator(2),
                            ],
                          ),
                          SizedBox(height: 24.h),

                          // Form carousel
                          FlutterCarousel(
                            options: FlutterCarouselOptions(
                              height: 275.h,
                              initialPage: 0,
                              showIndicator: false,
                              viewportFraction: 1,
                              controller: buttonCarouselController,
                              onPageChanged: (int index, func) {
                                setState(() {
                                  indexPage = index;
                                  _errors
                                      .clear(); // Clear errors on page change
                                });
                              },
                            ),
                            items: [
                              _buildFirstPage(),
                              _buildSecondPage(),
                              _buildThirdPage(),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          // Action button
                          BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              final isLoading = state is SignUpLoading;
                              return Container(
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
                                    onTap: isLoading ? null : _nextPage,
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
                                          : Text(
                                              indexPage == 2
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .register
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .next,
                                              style: TextStyle(
                                                color: const Color(0xFF0148C9),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 24.h),

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
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
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

                          // Sign in link
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
                                  AppLocalizations.of(context)!
                                      .alreadyHaveAccount,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int page) {
    final isActive = indexPage == page;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 32.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
    );
  }
}
