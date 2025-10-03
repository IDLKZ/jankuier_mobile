import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';

/// Виджет для выбора количества товара
class InputQty extends StatefulWidget {
  /// Максимальное значение
  final int maxVal;

  /// Начальное значение
  final int initVal;

  /// Минимальное значение
  final int minVal;

  /// Шаг изменения
  final int steps;

  /// Callback при изменении количества
  final ValueChanged<int> onQtyChanged;

  const InputQty({
    super.key,
    required this.maxVal,
    required this.initVal,
    required this.minVal,
    required this.steps,
    required this.onQtyChanged,
  });

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initVal.clamp(widget.minVal, widget.maxVal);
  }

  void _increment() {
    if (_currentValue + widget.steps <= widget.maxVal) {
      setState(() {
        _currentValue += widget.steps;
      });
      widget.onQtyChanged(_currentValue);
    }
  }

  void _decrement() {
    if (_currentValue - widget.steps >= widget.minVal) {
      setState(() {
        _currentValue -= widget.steps;
      });
      widget.onQtyChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onPressed: _currentValue > widget.minVal ? _decrement : null,
          ),
          SizedBox(width: 16.w),
          Container(
            constraints: BoxConstraints(minWidth: 40.w),
            child: Text(
              _currentValue.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          _buildButton(
            icon: Icons.add,
            onPressed: _currentValue < widget.maxVal ? _increment : null,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: onPressed != null
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.grey200,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: onPressed != null ? AppColors.primary : AppColors.grey400,
          ),
        ),
      ),
    );
  }
}
