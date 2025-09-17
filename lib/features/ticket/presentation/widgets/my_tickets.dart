import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jankuier_mobile/core/constants/order_status_constants.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_ticketon_order_parameter.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/paginate_ticket_order/paginate_ticket_order_bloc.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/ticketon_order_check/ticketon_order_check_bloc.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/ticketon_order_check/ticketon_order_check_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/ticketon_order_check/ticketon_order_check_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../pages/repayment_webview_page.dart';
import '../../../../core/di/injection.dart';
import '../../data/entities/ticket_order/ticket_order_entity.dart';
import '../bloc/paginate_ticket_order/paginate_ticket_order_event.dart';
import '../bloc/paginate_ticket_order/paginate_ticket_order_state.dart';

class MyTicketsWidget extends StatefulWidget {
  const MyTicketsWidget({super.key});

  @override
  State<MyTicketsWidget> createState() => _MyTicketsWidgetState();
}

class _MyTicketsWidgetState extends State<MyTicketsWidget> {
  PaginateTicketonOrderParameter myTicketParameter =
      const PaginateTicketonOrderParameter(
        perPage: 20,
        page: 1,
        orderBy: "id",
        orderDirection: "desc",
      );

  void _showOrderDetailsBottomSheet(
      BuildContext context, TicketonOrderEntity order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailsBottomSheet(
        order: order,
        onShowQRCode: () => _showQRCodeBottomSheet(context, order),
      ),
    );
  }

  void _showQRCodeBottomSheet(BuildContext context, TicketonOrderEntity order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QRCodeBottomSheet(order: order),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return getIt<PaginateTicketOrderBloc>()
          ..add(PaginateTicketOrderEvent(myTicketParameter));
      },
      child: BlocBuilder<PaginateTicketOrderBloc, PaginateTicketOrderState>(
          builder: (context, state) {
        if (state is PaginateTicketOrderLoadedState) {
          if (state.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.ticket_discount_copy,
                    size: 64.sp,
                    color: AppColors.grey300,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'У вас пока нет заказов',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Заказанные билеты будут отображаться здесь',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.grey400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<PaginateTicketOrderBloc>()
                  .add(PaginateTicketOrderEvent(myTicketParameter));
            },
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return TicketOrderCard(
                  order: order,
                  onTap: () {
                    _showOrderDetailsBottomSheet(context, order);
                  },
                );
              },
            ),
          );
        }

        if (state is PaginateTicketOrderLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        if (state is PaginateTicketOrderFailedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.info_circle_copy,
                  size: 64.sp,
                  color: AppColors.error,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Ошибка загрузки',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.failureData.message ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<PaginateTicketOrderBloc>()
                        .add(PaginateTicketOrderEvent(myTicketParameter));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Повторить'),
                ),
              ],
            ),
          );
        }

        return SizedBox();
      }),
    );
  }
}

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
            offset: Offset(0, 2),
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
            OrderStatusConstants.getStatus(order.status!),
            SizedBox(height: 4.h),
            // Header with event name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    order.showInfo.event?.name ?? 'Без названия',
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
                SizedBox(width: 8.w),
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
                    _getStatusText(order),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(order),
                    ),
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
                    '${order.showInfo.place?.name ?? "Неизвестное место"} • ${order.showInfo.city?.name ?? "Неизвестный город"}',
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
                  'Заказ #${order.id}',
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
                          'Сумма',
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
                        'Билетов',
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

  String _getStatusText(TicketonOrderEntity order) {
    if (order.isCanceled) return 'ОТМЕНЕН';
    if (order.isPaid) return 'ОПЛАЧЕН';
    if (order.isActive) return 'АКТИВЕН';
    return 'НЕАКТИВЕН';
  }

  Widget _getCompactAction(BuildContext context,
      TicketonOrderEntity order, VoidCallback onShowDetails) {
    switch (order.statusId) {
      case (OrderStatusConstants.created || OrderStatusConstants.paidAwaiting):
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RepaymentWebViewPage(
                  orderId: order.id.toString(),
                ),
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
              'Купить',
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
              'Детали',
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
                        'Детали заказа #${order.id}',
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
                          _getStatusText(order),
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
                    decoration: BoxDecoration(
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
                          order.showInfo.event?.name ?? 'Без названия',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (order.showInfo.event?.genre != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            'Жанр: ${order.showInfo.event!.genre}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        if (order.showInfo.event?.duration != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            'Длительность: ${order.showInfo.event!.duration} мин',
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
                    title: 'Место проведения',
                    icon: Iconsax.location,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (order.showInfo.place != null) ...[
                          Text(
                            order.showInfo.place!.name ?? 'Неизвестное место',
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
                                    'Неизвестный город',
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
                                'Зал: ${order.showInfo.hall!.name ?? "Неизвестный зал"}',
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
                    title: 'Дата и время',
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
                      title: 'Билеты',
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
                                              'Билет ${index + 1}',
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
                                                'Ряд ${ticket.row}, Место ${ticket.num}',
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
                                                'Уровень: ${ticket.level}',
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
                    title: 'Информация о заказе',
                    icon: Iconsax.receipt,
                    child: Column(
                      children: [
                        _buildInfoRow('Количество билетов',
                            '${order.tickets?.length ?? order.preTickets?.length ?? 0}'),
                        if (order.sum != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow('Общая стоимость',
                              '${order.sum!.toStringAsFixed(0)} ${order.currency ?? "₸"}',
                              isHighlighted: true),
                        ],
                        if (order.email != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow('Email', order.email!),
                        ],
                        if (order.phone != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow('Телефон', order.phone!),
                        ],
                        SizedBox(height: 8.h),
                        _buildInfoRow('Дата создания',
                            dateFormatter.format(order.createdAt.toLocal())),
                        if (order.cancelReason != null) ...[
                          SizedBox(height: 8.h),
                          _buildInfoRow('Причина отмены', order.cancelReason!,
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
            decoration: BoxDecoration(
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
                    'Отменить заказ',
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
                        'Оплатить заказ',
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
                      'Показать пропуск',
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
                    'Закрыть',
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

  String _getStatusText(TicketonOrderEntity order) {
    if (order.isCanceled) return 'ОТМЕНЕН';
    if (order.isPaid) return 'ОПЛАЧЕН';
    if (order.isActive) return 'АКТИВЕН';
    return 'НЕАКТИВЕН';
  }
}

class QRCodeBottomSheet extends StatelessWidget {
  final TicketonOrderEntity order;

  const QRCodeBottomSheet({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TicketonOrderCheckBloc>()
        ..add(TicketonOrderCheckEvent(order.id)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: BlocBuilder<TicketonOrderCheckBloc, TicketonOrderCheckState>(
          builder: (context, state) {
            return Column(
              children: [
                // Handle bar
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
                              'Пропуск на мероприятие',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Заказ #${order.id}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppColors.grey100,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Iconsax.close_square_copy,
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
                  child: _buildContent(context, state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TicketonOrderCheckState state) {
    if (state is TicketonOrderCheckLoadingState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16.h),
            Text(
              'Загрузка пропуска...',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    if (state is TicketonOrderCheckFailedState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.info_circle_copy,
              size: 64.sp,
              color: AppColors.error,
            ),
            SizedBox(height: 16.h),
            Text(
              'Ошибка загрузки пропуска',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.failureData.message ?? 'Неизвестная ошибка',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is TicketonOrderCheckSuccessState) {
      return _buildQRCodeContent(context, state.orderCheck);
    }

    return Container();
  }

  Widget _buildQRCodeContent(BuildContext context, orderCheck) {
    final tickets = orderCheck.orderCheck?.tickets;
    final show = orderCheck.orderCheck?.show;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Event Info
          if (show != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    show.description ?? 'Мероприятие',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (show.place != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      show.place!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (show.date != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      show.date!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],

          // QR Codes
          if (tickets != null && tickets.isNotEmpty) ...[
            Expanded(
              child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticketEntry = tickets.entries.elementAt(index);
                  final ticket = ticketEntry.value;

                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.grey200),
                    ),
                    child: Column(
                      children: [
                        // Ticket Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (ticket.row != null && ticket.number != null)
                                    Text(
                                      'Ряд ${ticket.row}, Место ${ticket.number}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  if (ticket.level != null)
                                    Text(
                                      'Уровень: ${ticket.level}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // QR Code
                        if (ticket.qr != null && ticket.qr!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.grey200),
                            ),
                            child: QrImageView(
                              data: ticket.qr!,
                              version: QrVersions.auto,
                              size: 200.w,
                            ),
                          )
                        else
                          Container(
                            height: 200.w,
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                'QR-код недоступен',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.ticket_copy,
                      size: 64.sp,
                      color: AppColors.grey400,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'QR-коды не найдены',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Close Button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Закрыть',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
