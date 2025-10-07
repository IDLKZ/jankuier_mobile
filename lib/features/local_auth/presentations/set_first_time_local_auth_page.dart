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

class SetFirstTimeLocalAuthTypePage extends StatelessWidget {
  const SetFirstTimeLocalAuthTypePage({super.key});

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
      child: const _SetFirstTimeLocalAuthTypePageContent(),
    );
  }
}

class _SetFirstTimeLocalAuthTypePageContent extends StatefulWidget {
  const _SetFirstTimeLocalAuthTypePageContent();

  @override
  State<_SetFirstTimeLocalAuthTypePageContent> createState() =>
      _SetFirstTimeLocalAuthTypePageContentState();
}

class _SetFirstTimeLocalAuthTypePageContentState
    extends State<_SetFirstTimeLocalAuthTypePageContent> {
  final _pinController = TextEditingController();
  final _hiveUtils = getIt<HiveUtils>();
  bool _biometricChecked = false;
  bool _biometricAvailable = false;
  bool _isPinComplete = false;

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
    final localizations = AppLocalizations.of(context);
    if (localizations != null) {
      context.read<LocalAuthBloc>().add(
            AuthenticateWithBiometrics(
              message: localizations.giveAccessToData,
            ),
          );
    }
  }

  Future<void> _handlePinSubmit() async {
    if (_pinController.text.length == 4) {
      context.read<LocalAuthBloc>().add(SetPinCode(pin: _pinController.text));
    }
  }

  Future<void> _handleSuccessfulPinSetup() async {
    // Проверяем наличие refresh token
    final refreshToken = await _hiveUtils.getRefreshToken();

    if (refreshToken != null && refreshToken.isNotEmpty) {
      // Если есть refresh token, обновляем токен
      if (mounted) {
        context.read<RefreshTokenBloc>().add(
              RefreshTokenSubmitted(
                RefreshTokenParameter(refreshToken: refreshToken),
              ),
            );
      }
    } else {
      // Если нет refresh token, сразу переходим на главную
      if (mounted) {
        context.go(AppRouteConstants.HomePagePath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
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
            } else if (state is PinSetSuccess) {
              // PIN успешно установлен
              _handleSuccessfulPinSetup();
            } else if (state is PinSetFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        ),
        BlocListener<RefreshTokenBloc, RefreshTokenState>(
          listener: (context, state) {
            if (state is RefreshTokenSuccess) {
              // Token успешно обновлен, переходим на главную
              context.go(AppRouteConstants.HomePagePath);
            } else if (state is RefreshTokenFailure) {
              // Ошибка обновления токена, все равно переходим на главную
              context.go(AppRouteConstants.HomePagePath);
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
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      // Заголовок
                      Text(
                        l10n.securitySetup,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),

                      // Подзаголовок
                      Text(
                        _biometricAvailable
                            ? l10n.useBiometricsOrCreatePin
                            : l10n.createFourDigitPin,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),

                      // Иконка
                      if (_biometricAvailable)
                        Icon(
                          Icons.fingerprint,
                          size: 60.sp,
                          color: AppColors.primary,
                        )
                      else
                        Icon(
                          Icons.lock_outline,
                          size: 60.sp,
                          color: AppColors.primary,
                        ),
                      SizedBox(height: 32.h),

                      // PIN input
                      Pinput(
                        controller: _pinController,
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        obscureText: true,
                        obscuringCharacter: '●',
                        onChanged: _onPinChanged,
                        onCompleted: (pin) {
                          _handlePinSubmit();
                        },
                        keyboardType: TextInputType.number,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                      ),
                      SizedBox(height: 24.h),

                      // Кнопка подтверждения
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
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
                                  height: 20.h,
                                  width: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  l10n.continueButton,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      // Повторная попытка биометрии
                      if (_biometricAvailable) ...[
                        SizedBox(height: 16.h),
                        TextButton.icon(
                          onPressed: () {
                            _handleBiometricAuthentication();
                          },
                          icon: Icon(Icons.fingerprint, size: 20.sp),
                          label: Text(
                            l10n.useBiometrics,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                      ],
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
