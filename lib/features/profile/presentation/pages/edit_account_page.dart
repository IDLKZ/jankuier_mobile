import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/constants/form_validation_constants.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_profile_parameter.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../auth/data/entities/user_entity.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailC = TextEditingController();
  final _firstNameC = TextEditingController();
  final _lastNameC = TextEditingController();
  final _patronomicC = TextEditingController();
  final _phoneC = TextEditingController();
  final _iinC = TextEditingController();
  UserEntity? currentUser;

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
        _emailC.text = user.email;
        _firstNameC.text = user.firstName;
        _lastNameC.text = user.lastName;
        _patronomicC.text = user.patronomic ?? '';
        _phoneC.text = user.phone;
        _iinC.text = user.iin ?? '';
      });
    }
  }

  @override
  void dispose() {
    _emailC.dispose();
    _firstNameC.dispose();
    _lastNameC.dispose();
    _patronomicC.dispose();
    _phoneC.dispose();
    _iinC.dispose();
    super.dispose();
  }

  // Validation methods
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

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterPhone;
    }
    final phone = value.trim();
    final re = RegExp(FormValidationConstant.PhoneRegExp);
    if (!re.hasMatch(phone)) {
      return AppLocalizations.of(context)!.phoneFormat;
    }
    return null;
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterFirstName;
    }
    if (value.trim().length < 2) {
      return AppLocalizations.of(context)!.firstNameMinChars;
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
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updateProfileParameter = UpdateProfileParameter(
        email: _emailC.text.trim(),
        phone: _phoneC.text.trim(),
        firstName: _firstNameC.text.trim(),
        lastName: _lastNameC.text.trim(),
        patronymic:
            _patronomicC.text.trim().isEmpty ? null : _patronomicC.text.trim(),
        iin: _iinC.text.trim().isEmpty ? null : _iinC.text.trim(),
      );

      context
          .read<UpdateProfileBloc>()
          .add(ProfileUpdateSubmitted(updateProfileParameter));
    }
  }

  // Widget builders
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMeBloc>(
          create: (context) => getIt<GetMeBloc>(),
        ),
        BlocProvider<UpdateProfileBloc>(
          create: (context) => getIt<UpdateProfileBloc>(),
        ),
      ],
      child: const _EditAccountView(),
    );
  }
}

class _EditAccountView extends StatefulWidget {
  const _EditAccountView();

  @override
  State<_EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<_EditAccountView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailC = TextEditingController();
  final _firstNameC = TextEditingController();
  final _lastNameC = TextEditingController();
  final _patronomicC = TextEditingController();
  final _phoneC = TextEditingController();
  final _iinC = TextEditingController();
  UserEntity? currentUser;

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
        _emailC.text = user.email;
        _firstNameC.text = user.firstName;
        _lastNameC.text = user.lastName;
        _patronomicC.text = user.patronomic ?? '';
        _phoneC.text = user.phone;
        _iinC.text = user.iin ?? '';
      });
    }
  }

  @override
  void dispose() {
    _emailC.dispose();
    _firstNameC.dispose();
    _lastNameC.dispose();
    _patronomicC.dispose();
    _phoneC.dispose();
    _iinC.dispose();
    super.dispose();
  }

  // Validation methods
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

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterPhone;
    }
    final phone = value.trim();
    final re = RegExp(FormValidationConstant.PhoneRegExp);
    if (!re.hasMatch(phone)) {
      return AppLocalizations.of(context)!.phoneFormat;
    }
    return null;
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterFirstName;
    }
    if (value.trim().length < 2) {
      return AppLocalizations.of(context)!.firstNameMinChars;
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
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updateProfileParameter = UpdateProfileParameter(
        email: _emailC.text.trim(),
        phone: _phoneC.text.trim(),
        firstName: _firstNameC.text.trim(),
        lastName: _lastNameC.text.trim(),
        patronymic:
            _patronomicC.text.trim().isEmpty ? null : _patronomicC.text.trim(),
        iin: _iinC.text.trim().isEmpty ? null : _iinC.text.trim(),
      );

      context
          .read<UpdateProfileBloc>()
          .add(ProfileUpdateSubmitted(updateProfileParameter));
    }
  }

  // Widget builders
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
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
        title: AppLocalizations.of(context)!.data,
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.profileSuccessfullyUpdated),
                    backgroundColor: Colors.green,
                  ),
                );
                context.read<GetMeBloc>().add(const RefreshUserProfile());
                context.go(AppRouteConstants.ProfilePagePath);
              } else if (state is UpdateProfileFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.personalInformation,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  _buildTextFormField(
                    controller: _lastNameC,
                    labelText: AppLocalizations.of(context)!.lastName,
                    validator: _validateLastName,
                  ),

                  _buildTextFormField(
                    controller: _firstNameC,
                    labelText: AppLocalizations.of(context)!.firstName,
                    validator: _validateFirstName,
                  ),

                  _buildTextFormField(
                    controller: _patronomicC,
                    labelText: AppLocalizations.of(context)!.patronymicOptional,
                    validator: (value) => null, // Optional field
                  ),

                  _buildTextFormField(
                    controller: _emailC,
                    labelText: AppLocalizations.of(context)!.email,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  _buildTextFormField(
                    controller: _phoneC,
                    labelText: AppLocalizations.of(context)!.phoneNumber,
                    validator: _validatePhone,
                    keyboardType: TextInputType.phone,
                  ),

                  _buildTextFormField(
                    controller: _iinC,
                    labelText: AppLocalizations.of(context)!.iinOptional,
                    validator: (value) => null, // Optional field
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 20.h),

                  // Submit button
                  BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                    builder: (context, state) {
                      final isLoading = state is UpdateProfileLoading;
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
                                  AppLocalizations.of(context)!.saveChanges,
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
