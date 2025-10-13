import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/order_status_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/entities/ticket_order/ticket_order_entity.dart';
import '../pages/repayment_webview_page.dart';

class TicketOrderCard extends StatelessWidget {
  final TicketonOrderEntity order;
  final VoidCallback onTap;

  const TicketOrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMM yyyy, HH:mm', 'ru');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatusConstants.getStatus(order.status!, context),
            SizedBox(height: 4.h),
            // Header with event name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    order.showInfo.event?.name ??
                        AppLocalizations.of(context)!.untitled,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Location and date row
            Row(
              children: [
                Icon(
                  Iconsax.location_copy,
                  size: 12.sp,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    '${order.showInfo.place?.name ?? AppLocalizations.of(context)!.unknownLocation} • ${order.showInfo.city?.name ?? AppLocalizations.of(context)!.unknownCity}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Iconsax.calendar_copy,
                  size: 12.sp,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 4.w),
                Text(
                  dateFormatter.format(order.createdAt.toLocal()),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                Spacer(),
                Text(
                  '${AppLocalizations.of(context)!.order}${order.id}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Price, tickets, and action button row
            Row(
              children: [
                if (order.sum != null) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.amount,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${order.sum!.toStringAsFixed(0)} ${order.currency ?? "₸"}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.ticketsCount,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${order.tickets?.length ?? order.preTickets?.length ?? 0}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _getCompactAction(context, order, onTap),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TicketonOrderEntity order) {
    if (order.isCanceled) return AppColors.error;
    if (order.isPaid) return AppColors.success;
    if (order.isActive) return AppColors.warning;
    return AppColors.grey400;
  }

  String _getStatusText(TicketonOrderEntity order, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (order.isCanceled) return localizations.statusCanceled;
    if (order.isPaid) return localizations.statusPaid;
    if (order.isActive) return localizations.statusActive;
    return localizations.statusInactive;
  }

  Widget _getCompactAction(BuildContext context, TicketonOrderEntity order,
      VoidCallback onShowDetails) {
    switch (order.statusId) {
      case (OrderStatusConstants.created || OrderStatusConstants.paidAwaiting):
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RepaymentWebViewPage(orderId: order.id.toString()),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              AppLocalizations.of(context)!.buy,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      default:
        return GestureDetector(
          onTap: onShowDetails,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              AppLocalizations.of(context)!.details,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
  }
}
