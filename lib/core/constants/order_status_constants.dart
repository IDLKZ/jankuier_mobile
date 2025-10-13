import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_status_entity.dart';

class OrderStatusConstants {
  static const int created = 1; // Booking created, awaiting payment
  static const int paidConfirmed = 2; // Paid and confirmed
  static const int paidAwaiting = 3; // Paid, awaiting confirmation
  static const int cancelled = 4; // Cancelled
  static const int cancelledRefundWait = 5; // Cancelled, awaiting refund
  static const int cancelledRefunded = 6; // Cancelled, refunded

  static Widget getStatus(
      TicketonOrderStatusEntity status, BuildContext context) {
    late String text = status.localizedTitle(context);
    late Color color;
    switch (status.id) {
      case created:
        color = AppColors.primaryLight; // синий
        break;
      case paidConfirmed:
      case cancelledRefunded:
        color = AppColors.success; // зелёный
        break;
      case paidAwaiting:
      case cancelledRefundWait:
        color = AppColors.warning; // жёлтый
        break;
      case cancelled:
        color = AppColors.error; // красный
        break;
      default:
        color = AppColors.grey700;
    }

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 10.sp),
        ),
      ],
    );
  }
}
