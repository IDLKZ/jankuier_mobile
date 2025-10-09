import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_password_parameter.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_event.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../auth/data/entities/user_entity.dart';
import '../../../auth/presentation/bloc/update_password_bloc/update_password_state.dart';
import '../../../auth/presentation/bloc/get_me_bloc/get_me_bloc.dart';
import '../../../auth/presentation/bloc/get_me_bloc/get_me_event.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UpdatePasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetMeBloc>(),
        ),
      ],
      child: const _EditPasswordView(),
    );
  }
}

class _EditPasswordView extends StatefulWidget {
  const _EditPasswordView();

  @override
  State<_EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<_EditPasswordView> {
  final _formKey = GlobalKey<FormState>();
  UserEntity? currentUser;

  // Controllers
  final _oldPasswordC = TextEditingController();
  final _newPasswordC = TextEditingController();
  final _confirmPasswordC = TextEditingController();

  @override
  void dispose() {
    _oldPasswordC.dispose();
    _newPasswordC.dispose();
    _confirmPasswordC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await HiveUtils().getCurrentUser();
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  // Validation methods
  String? _validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterCurrentPassword;
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterNewPasswordField;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMinSixChars;
    }
    if (value == _oldPasswordC.text) {
      return AppLocalizations.of(context)!.newPasswordMustDiffer;
    }
    final passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=]).{8,}$';
    final regex = RegExp(passwordPattern);
    if (!regex.hasMatch(value)) {
      return "Пароль должен содержать минимум 1 заглавную, 1 строчную букву, 1 цифру и 1 спецсимвол";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.repeatNewPasswordField;
    }
    if (value != _newPasswordC.text) {
      return AppLocalizations.of(context)!.passwordsNotMatch;
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatePasswordParameter = UpdatePasswordParameter(
        oldPassword: _oldPasswordC.text,
        newPassword: _newPasswordC.text,
      );

      context
          .read<UpdatePasswordBloc>()
          .add(PasswordUpdateSubmitted(updatePasswordParameter));
    }
  }

  // Widget builders
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        validator: validator,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: AppLocalizations.of(context)!.security,
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
        listener: (context, state) {
          if (state is UpdatePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.passwordSuccessfullyUpdated),
                backgroundColor: Colors.green,
              ),
            );
            context.read<GetMeBloc>().add(const LoadUserProfile());
            context.go(AppRouteConstants.ProfilePagePath);
          } else if (state is UpdatePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.passwordChange,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  _buildPasswordField(
                    controller: _oldPasswordC,
                    labelText: AppLocalizations.of(context)!.currentPassword,
                    validator: _validateOldPassword,
                  ),

                  _buildPasswordField(
                    controller: _newPasswordC,
                    labelText: AppLocalizations.of(context)!.newPassword,
                    validator: _validateNewPassword,
                  ),

                  _buildPasswordField(
                    controller: _confirmPasswordC,
                    labelText: AppLocalizations.of(context)!.repeatNewPassword,
                    validator: _validateConfirmPassword,
                  ),

                  SizedBox(height: 20.h),

                  // Submit button
                  BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
                    builder: (context, state) {
                      final isLoading = state is UpdatePasswordLoading;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onPressed: isLoading ? null : _submitForm,
                          child: isLoading
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.updatePassword,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
