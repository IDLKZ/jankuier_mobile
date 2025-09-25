import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';

class EditAccountForm extends StatelessWidget {
  const EditAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Смена пароля
          _SectionContainer(
            title: AppLocalizations.of(context)!.changePassword,
            children: [
              _LabeledTextField(
                  label: AppLocalizations.of(context)!.oldPassword, hint: AppLocalizations.of(context)!.enterOldPassword),
              _LabeledTextField(
                  label: AppLocalizations.of(context)!.newPassword, hint: AppLocalizations.of(context)!.enterNewPassword),
              _LabeledTextField(
                  label: AppLocalizations.of(context)!.repeatNewPassword,
                  hint: AppLocalizations.of(context)!.enterNewPassword),
              SizedBox(height: 12.h),
              _PrimaryButton(title: AppLocalizations.of(context)!.changePassword, onPressed: () {}),
            ],
          ),

          SizedBox(height: 16.h),

          // Смена почты
          _SectionContainer(
            title: AppLocalizations.of(context)!.changeEmail,
            children: [
              _LabeledTextField(label: AppLocalizations.of(context)!.email, hint: 'example@mail.com'),
              SizedBox(height: 12.h),
              _PrimaryButton(title: AppLocalizations.of(context)!.changeEmail, onPressed: () {}),
            ],
          ),

          SizedBox(height: 16.h),

          // Удалить аккаунт
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.person_outline, color: Colors.red),
                SizedBox(width: 8.w),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.deleteAccount,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionContainer({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;

  const _LabeledTextField({
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13.sp)),
          SizedBox(height: 4.h),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          backgroundColor: Color(0xFF0247C3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child:
            Text(title, style: TextStyle(fontSize: 14.sp, color: Colors.white)),
      ),
    );
  }
}
