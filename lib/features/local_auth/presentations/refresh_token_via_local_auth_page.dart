import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_route_constants.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/hive_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/domain/parameters/refresh_token_parameter.dart';
import '../../auth/presentation/bloc/refresh_token_bloc/refresh_token_bloc.dart';
import '../../auth/presentation/bloc/refresh_token_bloc/refresh_token_event.dart';
import '../../auth/presentation/bloc/refresh_token_bloc/refresh_token_state.dart';
import '../presentation/bloc/local_auth_bloc.dart';
import '../presentation/bloc/local_auth_event.dart';
import '../presentation/bloc/local_auth_state.dart';

class RefreshTokenViaLocalAuthPage extends StatelessWidget {
  const RefreshTokenViaLocalAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LocalAuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<RefreshTokenBloc>(),
        ),
      ],
      child: const _RefreshTokenViaLocalAuthPageContent(),
    );
  }
}

class _RefreshTokenViaLocalAuthPageContent extends StatefulWidget {
  const _RefreshTokenViaLocalAuthPageContent();

  @override
  State<_RefreshTokenViaLocalAuthPageContent> createState() =>
      _RefreshTokenViaLocalAuthPageContentState();
}

class _RefreshTokenViaLocalAuthPageContentState
    extends State<_RefreshTokenViaLocalAuthPageContent> {
  final _pinController = TextEditingController();
  final _hiveUtils = getIt<HiveUtils>();

  bool _biometricChecked = false;
  bool _biometricAvailable = false;
  bool _showPinInput = false;
  bool _isPinComplete = false;
  int _pinAttempts = 0;
  static const int _maxPinAttempts = 3;

  @override
  void initState() {
    super.initState();
    // Проверяем доступность биометрии при загрузке
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocalAuthBloc>().add(const CheckBiometricsAvailable());
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onPinChanged(String pin) {
    setState(() {
      _isPinComplete = pin.length == 4;
    });
  }

  Future<void> _handleBiometricAuthentication() async {
    final l10n = AppLocalizations.of(context)!;
    context.read<LocalAuthBloc>().add(
          AuthenticateWithBiometrics(
            message: l10n.giveAccessToData,
          ),
        );
  }

  Future<void> _handlePinSubmit() async {
    if (_pinController.text.length == 4) {
      context.read<LocalAuthBloc>().add(CheckPinCode(pin: _pinController.text));
    }
  }

  Future<void> _handleSuccessfulAuthentication() async {
    // Получаем refresh token
    final refreshToken = await _hiveUtils.getRefreshToken();

    if (refreshToken != null && refreshToken.isNotEmpty) {
      // Обновляем токен
      if (mounted) {
        context.read<RefreshTokenBloc>().add(
              RefreshTokenSubmitted(
                RefreshTokenParameter(refreshToken: refreshToken),
              ),
            );
      }
    } else {
      // Если нет refresh token, переходим на SignIn
      if (mounted) {
        context.go(AppRouteConstants.SignInPagePath);
      }
    }
  }

  void _showPinInputMode() {
    setState(() {
      _showPinInput = true;
    });
  }

  void _navigateToSignIn() async {
    await _hiveUtils.clearAllUserData();
    context.go(AppRouteConstants.SignInPagePath);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 64.w,
      height: 64.h,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
        color: AppColors.white,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.primary.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.primary),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.error, width: 2),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LocalAuthBloc, LocalAuthState>(
          listener: (context, state) {
            if (state is BiometricsAvailable) {
              if (!_biometricChecked) {
                setState(() {
                  _biometricChecked = true;
                  _biometricAvailable = true;
                });
                // Автоматически запускаем биометрическую аутентификацию
                _handleBiometricAuthentication();
              }
            } else if (state is BiometricsNotAvailable) {
              setState(() {
                _biometricChecked = true;
                _biometricAvailable = false;
              });
              // Биометрия недоступна, показываем PIN
              _showPinInputMode();
            } else if (state is AuthenticationSuccess) {
              // Биометрическая аутентификация успешна
              _handleSuccessfulAuthentication();
            } else if (state is AuthenticationFailure) {
              // Биометрия не прошла, показываем PIN
              _showPinInputMode();
            } else if (state is PinCheckSuccess) {
              // PIN верный, аутентификация успешна
              _handleSuccessfulAuthentication();
            } else if (state is PinCheckFailure) {
              // PIN неверный
              setState(() {
                _pinAttempts++;
                _pinController.clear();
                _isPinComplete = false;
              });

              if (_pinAttempts >= _maxPinAttempts) {
                // Превышено количество попыток
                final l10n = AppLocalizations.of(context)!;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.attemptsExceededLoginAgain),
                    backgroundColor: AppColors.error,
                  ),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  _navigateToSignIn();
                });
              } else {
                // Показываем ошибку
                final l10n = AppLocalizations.of(context)!;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.incorrectPinAttemptsRemaining(
                        _maxPinAttempts - _pinAttempts)),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            } else if (state is LocalAuthError) {
              // Общая ошибка - переходим на SignIn
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                _navigateToSignIn();
              });
            }
          },
        ),
        BlocListener<RefreshTokenBloc, RefreshTokenState>(
          listener: (context, state) {
            if (state is RefreshTokenSuccess) {
              // Token успешно обновлен, переходим на главную
              context.go(AppRouteConstants.HomePagePath);
            } else if (state is RefreshTokenFailure) {
              // Ошибка обновления токена, переходим на SignIn
              final l10n = AppLocalizations.of(context)!;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.failedToRefreshToken),
                  backgroundColor: AppColors.error,
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                _navigateToSignIn();
              });
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<LocalAuthBloc, LocalAuthState>(
            builder: (context, state) {
              final l10n = AppLocalizations.of(context)!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Заголовок
                    Text(
                      _showPinInput ? l10n.enterPinCode : l10n.appLogin,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),

                    // Подзаголовок
                    if (_showPinInput)
                      Text(
                        l10n.attemptsRemaining(_maxPinAttempts - _pinAttempts),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: _pinAttempts > 0
                              ? AppColors.error
                              : AppColors.textSecondary,
                          fontWeight: _pinAttempts > 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      )
                    else
                      Text(
                        l10n.confirmLoginWithBiometrics,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(height: 48.h),

                    // Иконка или индикатор загрузки
                    if (state is LocalAuthLoading)
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      )
                    else if (_showPinInput)
                      Icon(
                        Icons.lock_outline,
                        size: 80.sp,
                        color: AppColors.primary,
                      )
                    else
                      Icon(
                        Icons.fingerprint,
                        size: 80.sp,
                        color: AppColors.primary,
                      ),
                    SizedBox(height: 48.h),

                    // PIN input (показываем только если нужен PIN)
                    if (_showPinInput) ...[
                      Pinput(
                        controller: _pinController,
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        errorPinTheme: _pinAttempts > 0 ? errorPinTheme : null,
                        obscureText: true,
                        obscuringCharacter: '●',
                        onChanged: _onPinChanged,
                        onCompleted: (pin) {
                          _handlePinSubmit();
                        },
                        keyboardType: TextInputType.number,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                      ),
                      SizedBox(height: 32.h),

                      // Кнопка подтверждения PIN
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: _isPinComplete ? _handlePinSubmit : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            disabledBackgroundColor: AppColors.grey300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: state is LocalAuthLoading
                              ? SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  l10n.confirmButton,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],

                    // Кнопка повторной попытки биометрии
                    if (_biometricAvailable && _showPinInput) ...[
                      SizedBox(height: 24.h),
                      TextButton.icon(
                        onPressed: () {
                          _handleBiometricAuthentication();
                        },
                        icon: const Icon(Icons.fingerprint),
                        label: Text(l10n.useBiometrics),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ],

                    // Кнопка отмены (переход на SignIn)
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: _navigateToSignIn,
                      child: Text(
                        l10n.loginWithDifferentAccount,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
