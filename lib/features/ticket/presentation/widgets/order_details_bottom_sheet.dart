import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/order_status_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/entities/ticket_order/ticket_order_entity.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final TicketonOrderEntity order;
  final VoidCallback? onShowQRCode;

  const OrderDetailsBottomSheet({
    super.key,
    required this.order,
    this.onShowQRCode,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'ru');
    final dateOnly = DateFormat('d MMMM yyyy', 'ru');
    final timeOnly = DateFormat('HH:mm', 'ru');

    return Container(
      margin: EdgeInsets.only(top: 50.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.orderDetails}${order.id}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          _getStatusText(order, context),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(order),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: AppColors.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.close_circle_copy,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Information
                  _buildSectionCard(
                    title: 'Мероприятие',
                    icon: Iconsax.ticket,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.showInfo.event?.name ?? AppLocalizations.of(context)!.untitled,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (order.showInfo.event?.genre != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            '${AppLocalizations.of(context)!.genre} ${order.showInfo.event!.genre}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        if (order.showInfo.event?.duration != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            '${AppLocalizations.of(context)!.duration} ${order.showInfo.event!.duration} ${AppLocalizations.of(context)!.minutes}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Location Information
                  _buildSectionCard(
                    title: AppLocalizations.of(context)!.venue,
                    icon: Iconsax.location,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (order.showInfo.place != null) ...[
                          Text(
                            order.showInfo.place!.name ?? AppLocalizations.of(context)!.unknownLocation,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (order.showInfo.place!.address != null) ...[
                            SizedBox(height: 4.h),
                            Text(
                              order.showInfo.place!.address!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                        if (order.showInfo.city != null) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Iconsax.building,
                                size: 16.sp,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                order.showInfo.city!.name ??
                                    AppLocalizations.of(context)!.unknownCity,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (order.showInfo.hall != null) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Iconsax.home,
                                size: 16.sp,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${AppLocalizations.of(context)!.hall} ${order.showInfo.hall!.name ?? AppLocalizations.of(context)!.unknownHall}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Date & Time Information
                  _buildSectionCard(
                    title: AppLocalizations.of(context)!.dateAndTime,
                    icon: Iconsax.calendar,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              dateOnly.format(order.createdAt.toLocal()),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Iconsax.clock,
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              timeOnly.format(order.createdAt.toLocal()),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Tickets Information
                  if ((order.tickets != null && order.tickets!.isNotEmpty) ||
                      (order.preTickets != null &&
                          order.preTickets!.isNotEmpty)) ...[
                    _buildSectionCard(
                      title: AppLocalizations.of(context)!.tickets,
                      icon: Iconsax.ticket_discount,
                      child: Column(
                        children: [
                          ...(order.tickets ?? order.preTickets)!
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final ticket = entry.value;
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: index <
                                      (order.tickets ??
                                          order.preTickets)!
                                          .length -
                                          1
                                      ? 8.h
                                      : 0),
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.grey200,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32.w,
                                    height: 32.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(
                                      Iconsax.ticket,
                                      size: 16.sp,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.ticket} ${index + 1}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        if (ticket.row != null &&
                                            ticket.num != null) ...[
                                          SizedBox(height: 2.h),
                                          Text(
                                            '${AppLocalizations.of(context)!.row} ${ticket.row}, ${AppLocalizations.of(context)!.seat} ${ticket.num}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                              AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                        if (ticket.level != null) ...[
                                          SizedBox(height: 2.h),
                                          Text(
                                            '${AppLocalizations.of(context)!.level} ${ticket.level}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                              AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  if (ticket.cost != null) ...[
                                    Text(
                                      '${ticket.cost} ${order.currency ?? "₸"}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }) ??
                              [],
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                  // Order Summary
                  _buildSectionCard(
                    title: AppLocalizations.of(context)!.orderInformation,
                    icon: Iconsax.receipt,
                    child: Column(
                      children: [
                        _buildInfoRow(AppLocalizations.of(context)!.ticketCount,
                            '${order.tickets?.length ?? order.preTickets?.length ?? 0}'),
                        if (order.sum != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow(AppLocalizations.of(context)!.totalCost,
                              '${order.sum!.toStringAsFixed(0)} ${order.currency ?? "₸"}',
                              isHighlighted: true),
                        ],
                        if (order.email != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow('Email', order.email!),
                        ],
                        if (order.phone != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow(AppLocalizations.of(context)!.phone, order.phone!),
                        ],
                        SizedBox(height: 8.h),
                        _buildInfoRow(AppLocalizations.of(context)!.dateCreated,
                            dateFormatter.format(order.createdAt.toLocal())),
                        if (order.cancelReason != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow(AppLocalizations.of(context)!.cancellationReason, order.cancelReason!,
                              isError: true),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          // Bottom Actions
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.grey200,
                  width: 1,
                ),
              ),
            ),
            child: _buildBottomActions(order, context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.grey200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isHighlighted = false, bool isError = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
              color: isError
                  ? AppColors.error
                  : (isHighlighted ? AppColors.primary : AppColors.textPrimary),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(TicketonOrderEntity order, BuildContext context) {
    switch (order.statusId) {
      case (OrderStatusConstants.created || OrderStatusConstants.paidAwaiting):
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.cancelOrder,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.wallet,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppLocalizations.of(context)!.payOrder,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return Column(
          children: [
            //Показать QR - CODE только если статус (2) оплачен и забронирован
            if (order.isPaid && order.statusId == 2) ...[
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    if (onShowQRCode != null) {
                      onShowQRCode!();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.showPass,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.close,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
    }
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
}