import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class EditAccountForm extends StatelessWidget {
  final bool showChangePassword;
  final bool showChangeEmail;
  final bool showDeleteAccount;
  const EditAccountForm(
      {super.key,
        this.showChangeEmail = true,
        this.showChangePassword = true,
        this.showDeleteAccount = true});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(5.r)),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}