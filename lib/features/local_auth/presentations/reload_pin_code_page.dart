import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_route_constants.dart';
import '../../../core/di/injection.dart';
import '../../../l10n/app_localizations.dart';
import '../presentation/bloc/local_auth_bloc.dart';
import '../presentation/bloc/local_auth_event.dart';
import '../presentation/bloc/local_auth_state.dart';

class ReloadPinCodePage extends StatelessWidget {
  const ReloadPinCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocalAuthBloc>()..add(const CheckPinExists()),
      child: const _ReloadPinCodePageContent(),
    );
  }
}

class _ReloadPinCodePageContent extends StatefulWidget {
  const _ReloadPinCodePageContent();

  @override
  State<_ReloadPinCodePageContent> createState() =>
      _ReloadPinCodePageContentState();
}

class _ReloadPinCodePageContentState extends State<_ReloadPinCodePageContent> {
  final _newPinController = TextEditingController();
  final _oldPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  bool _pinExists = false;
  bool _isChecking = true;
  bool _isNewPinComplete = false;
  bool _isOldPinComplete = false;
  bool _isConfirmPinComplete = false;
  int _attempts = 0;
  static const int _maxAttempts = 3;
  bool _showOldPinError = false;

  @override
  void dispose() {
    _newPinController.dispose();
    _oldPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _onNewPinChanged(String pin) {
    setState(() {
      _isNewPinComplete = pin.length == 4;
    });
  }

  void _onOldPinChanged(String pin) {
    setState(() {
      _isOldPinComplete = pin.length == 4;
      _showOldPinError = false;
    });
  }

  void _onConfirmPinChanged(String pin) {
    setState(() {
      _isConfirmPinComplete = pin.length == 4;
    });
  }

  void _handleCreatePin() {
    if (_newPinController.text.length == 4 &&
        _confirmPinController.text.length == 4) {
      if (_newPinController.text != _confirmPinController.text) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pinCodesDoNotMatch),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      context
          .read<LocalAuthBloc>()
          .add(SetPinCode(pin: _newPinController.text));
    }
  }

  void _handleUpdatePin() {
    if (_oldPinController.text.length == 4 &&
        _newPinController.text.length == 4 &&
        _confirmPinController.text.length == 4) {
      if (_newPinController.text != _confirmPinController.text) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.newPinCodesDoNotMatch),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      context.read<LocalAuthBloc>().add(
            UpdatePinCode(
              oldPin: _oldPinController.text,
              newPin: _newPinController.text,
            ),
          );
    }
  }

  void _navigateToProfile() {
    context.go(AppRouteConstants.ProfilePagePath);
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

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.error, width: 2),
      ),
    );

    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        if (state is PinExists) {
          setState(() {
            _pinExists = true;
            _isChecking = false;
          });
        } else if (state is PinNotExists) {
          setState(() {
            _pinExists = false;
            _isChecking = false;
          });
        } else if (state is PinSetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pinCodeSuccessfullySet),
              backgroundColor: AppColors.success,
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            _navigateToProfile();
          });
        } else if (state is PinSetFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is PinUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pinCodeSuccessfullyUpdated),
              backgroundColor: AppColors.success,
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            _navigateToProfile();
          });
        } else if (state is PinUpdateFailure) {
          setState(() {
            _attempts++;
            _oldPinController.clear();
            _isOldPinComplete = false;
            _showOldPinError = true;
          });

          if (_attempts >= _maxAttempts) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.attemptsExceeded),
                backgroundColor: AppColors.error,
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              _navigateToProfile();
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.incorrectOldPinAttemptsRemaining(
                    _maxAttempts - _attempts)),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      },
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.background,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: AppColors.textPrimary),
                  onPressed: _navigateToProfile,
                ),
                title: Text(
                  _pinExists ? l10n.changePinCode : l10n.createPinCode,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              body: SafeArea(
                child: _isChecking
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),

                              // Иконка
                              Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  size: 60.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 24.h),

                              // Описание
                              Center(
                                child: Text(
                                  _pinExists
                                      ? l10n.enterOldAndNewPin
                                      : l10n.createFourDigitPin,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 32.h),

                              // Поле для старого PIN (только если PIN существует)
                              if (_pinExists) ...[
                                Text(
                                  l10n.oldPinCode,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Center(
                                  child: Pinput(
                                    controller: _oldPinController,
                                    length: 4,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    errorPinTheme:
                                        _showOldPinError ? errorPinTheme : null,
                                    obscureText: true,
                                    obscuringCharacter: '●',
                                    onChanged: _onOldPinChanged,
                                    keyboardType: TextInputType.number,
                                    hapticFeedbackType:
                                        HapticFeedbackType.lightImpact,
                                  ),
                                ),
                                if (_attempts > 0) ...[
                                  SizedBox(height: 8.h),
                                  Center(
                                    child: Text(
                                      l10n.attemptsRemaining(
                                          _maxAttempts - _attempts),
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                                SizedBox(height: 20.h),
                              ],

                              // Поле для нового PIN
                              Text(
                                _pinExists ? l10n.newPinCode : l10n.pinCode,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Center(
                                child: Pinput(
                                  controller: _newPinController,
                                  length: 4,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  obscureText: true,
                                  obscuringCharacter: '●',
                                  onChanged: _onNewPinChanged,
                                  keyboardType: TextInputType.number,
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                ),
                              ),
                              SizedBox(height: 20.h),

                              // Поле для подтверждения PIN
                              Text(
                                l10n.confirmPinCode,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Center(
                                child: Pinput(
                                  controller: _confirmPinController,
                                  length: 4,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  obscureText: true,
                                  obscuringCharacter: '●',
                                  onChanged: _onConfirmPinChanged,
                                  keyboardType: TextInputType.number,
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                ),
                              ),
                              SizedBox(height: 32.h),

                              // Кнопка подтверждения
                              BlocBuilder<LocalAuthBloc, LocalAuthState>(
                                builder: (context, state) {
                                  final isLoading = state is LocalAuthLoading;
                                  final isButtonEnabled = _pinExists
                                      ? (_isOldPinComplete &&
                                          _isNewPinComplete &&
                                          _isConfirmPinComplete)
                                      : (_isNewPinComplete &&
                                          _isConfirmPinComplete);

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 48.h,
                                    child: ElevatedButton(
                                      onPressed: isButtonEnabled && !isLoading
                                          ? (_pinExists
                                              ? _handleUpdatePin
                                              : _handleCreatePin)
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.white,
                                        disabledBackgroundColor:
                                            AppColors.grey300,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                      ),
                                      child: isLoading
                                          ? SizedBox(
                                              height: 20.h,
                                              width: 20.w,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.white,
                                              ),
                                            )
                                          : Text(
                                              _pinExists
                                                  ? l10n.updatePinCode
                                                  : l10n.createPinCode,
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 32.h),
                            ],
                          ),
                        ),
                      ),
              ));
        },
      ),
    );
  }
}
