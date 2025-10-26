import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jankuier_mobile/core/utils/price_formatter.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/hive_utils.dart';
import 'product_webview_page.dart';
import '../bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_bloc.dart';
import '../bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_event.dart';
import '../bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_state.dart';
import '../bloc/get_my_product_order_by_id/get_my_product_order_by_id_bloc.dart';
import '../bloc/get_my_product_order_by_id/get_my_product_order_by_id_event.dart';
import '../bloc/get_my_product_order_by_id/get_my_product_order_by_id_state.dart';
import '../../../../l10n/app_localizations.dart';

/// Страница деталей заказа продуктов
///
/// Отображает подробную информацию о заказе, включая:
/// - Информацию о заказе (статус, даты, контакты, итоговая сумма)
/// - Список товаров в заказе с подробностями
/// - Историю изменения статусов каждого товара
/// - Действия над заказом (отмена для статуса 2, удаление для статуса 1)
class ProductOrderDetailsPage extends StatefulWidget {
  /// ID заказа для отображения
  final int orderId;

  const ProductOrderDetailsPage({
    super.key,
    required this.orderId,
  });

  @override
  State<ProductOrderDetailsPage> createState() =>
      _ProductOrderDetailsPageState();
}

class _ProductOrderDetailsPageState extends State<ProductOrderDetailsPage> {
  // BLoC для загрузки информации о заказе (включая товары)
  // Возвращает FullProductOrderEntity с productOrder и productOrderItems
  late GetMyProductOrderByIdBloc _orderBloc;
  // BLoC для операций отмены/удаления заказа
  late CancelOrDeleteProductOrderBloc _actionBloc;

  @override
  void initState() {
    super.initState();
    // Инициализация BLoCs через DI
    _orderBloc = getIt<GetMyProductOrderByIdBloc>();
    _actionBloc = getIt<CancelOrDeleteProductOrderBloc>();

    // Загрузка данных заказа (включая список товаров)
    _orderBloc.add(LoadMyProductOrderById(widget.orderId));
  }

  @override
  void dispose() {
    // Закрытие BLoCs при уничтожении виджета
    _orderBloc.close();
    _actionBloc.close();
    super.dispose();
  }

  /// Показывает диалог подтверждения отмены заказа
  /// Доступно только для заказов со статусом 2 (оплачено)
  void _showCancelDialog(ProductOrderEntity order) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Иконка
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_rounded,
                  size: 48.sp,
                  color: AppColors.warning,
                ),
              ),
              SizedBox(height: 20.h),
              // Заголовок
              Text(
                AppLocalizations.of(context)!.cancelOrder,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              // Описание
              Text(
                AppLocalizations.of(context)!.cancelOrderConfirmation,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              // Кнопки
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: const BorderSide(color: AppColors.grey300),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        _actionBloc.add(
                          CancelOrDeleteOrder(widget.orderId),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Показывает диалог подтверждения удаления заказа
  /// Доступно только для заказов со статусом 1 (ожидают оплаты)
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Иконка
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_forever_rounded,
                  size: 48.sp,
                  color: AppColors.error,
                ),
              ),
              SizedBox(height: 20.h),
              // Заголовок
              Text(
                AppLocalizations.of(context)!.deleteOrder,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              // Описание
              Text(
                AppLocalizations.of(context)!.deleteOrderConfirmation,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              // Кнопки
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: const BorderSide(color: AppColors.grey300),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        _actionBloc.add(CancelOrDeleteOrder(widget.orderId));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.delete,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: AppLocalizations.of(context)!.myOrders,
        leadingIcon: Icons.arrow_back_ios_new,
        actionIcon: Icons.shopping_cart,
        onActionTap: () {
          context.push(AppRouteConstants.MyCartPagePath);
        },
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _orderBloc),
          BlocProvider.value(value: _actionBloc),
        ],
        child: BlocListener<CancelOrDeleteProductOrderBloc,
            CancelOrDeleteProductOrderState>(
          listener: (context, state) {
            if (state is CancelOrDeleteProductOrderSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: AppLocalizations.of(context)!.success,
                    message: AppLocalizations.of(context)!.success,
                    contentType: ContentType.success,
                  ),
                ),
              );
              // Перезагрузка данных заказа
              _orderBloc.add(LoadMyProductOrderById(widget.orderId));
            } else if (state is CancelOrDeleteProductOrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: AppLocalizations.of(context)!.error,
                    message: state.message,
                    contentType: ContentType.failure,
                  ),
                ),
              );
            }
          },
          child: RefreshIndicator(
            onRefresh: () async {
              _orderBloc.add(LoadMyProductOrderById(widget.orderId));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Карточка с информацией о заказе =====
                  BlocBuilder<GetMyProductOrderByIdBloc,
                      GetMyProductOrderByIdState>(
                    builder: (context, state) {
                      if (state is GetMyProductOrderByIdLoading) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.h),
                            child: const CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }

                      if (state is GetMyProductOrderByIdError) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48.sp,
                                color: AppColors.error,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                state.message,
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

                      if (state is GetMyProductOrderByIdLoaded) {
                        final order = state.order.productOrder;
                        if (order == null) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .orderDataNotAvailable,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }

                        return _OrderSummaryCard(
                          order: order,
                          // Кнопка "Оплатить" доступна для неоплаченных заказов
                          onPay: !order.isPaid
                              ? () async {
                                  final hiveUtils = getIt<HiveUtils>();
                                  final token =
                                      await hiveUtils.getAccessToken();
                                  if (token == null) {
                                    context
                                        .go(AppRouteConstants.SignInPagePath);
                                  } else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductWebViewPage(
                                          orderId: order.id.toString(),
                                          token: token,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          // Кнопка "Отменить" доступна только для статуса 2
                          onCancel: order.statusId == 2
                              ? () => _showCancelDialog(order)
                              : null,
                          // Кнопка "Удалить" доступна только для статуса 1
                          onDelete:
                              order.statusId == 1 ? _showDeleteDialog : null,
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),

                  SizedBox(height: 20.h),

                  // ===== Секция товаров в заказе =====
                  Text(
                    AppLocalizations.of(context)!.itemsInOrder,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Отображение товаров из того же BLoC
                  BlocBuilder<GetMyProductOrderByIdBloc,
                      GetMyProductOrderByIdState>(
                    builder: (context, state) {
                      if (state is GetMyProductOrderByIdLoading) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.h),
                            child: const CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }

                      if (state is GetMyProductOrderByIdError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.error,
                            ),
                          ),
                        );
                      }

                      if (state is GetMyProductOrderByIdLoaded) {
                        final items = state.order.productOrderItems ?? [];
                        if (items.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.h),
                              child: Text(
                                AppLocalizations.of(context)!.noItemsInOrder,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: items
                              .map((item) => _OrderItemCard(item: item))
                              .toList(),
                        );
                      }

                      return const SizedBox.shrink();
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

/// Виджет карточки с информацией о заказе
///
/// Отображает:
/// - Статус заказа с цветовой индикацией
/// - Даты создания, оплаты, срок оплаты
/// - Контактные данные (email, телефон)
/// - Итоговую сумму
/// - Кнопки действий (отмена/удаление) в зависимости от статуса
class _OrderSummaryCard extends StatelessWidget {
  final ProductOrderEntity order;

  /// Callback для отмены заказа (для статуса 2)
  final VoidCallback? onCancel;

  /// Callback для удаления заказа (для статуса 1)
  final VoidCallback? onDelete;

  /// Callback для оплаты заказа (для неоплаченных заказов)
  final VoidCallback? onPay;

  const _OrderSummaryCard({
    required this.order,
    this.onCancel,
    this.onDelete,
    this.onPay,
  });

  /// Определяет цвет статуса заказа
  /// - Success (зеленый): заказ оплачен
  /// - Error (красный): заказ отменен (статусы 3, 4, 5)
  /// - Warning (желтый): ожидает оплаты
  Color _getStatusColor() {
    if (order.isPaid) {
      return AppColors.success;
    } else if ([3, 4, 5].contains(order.statusId)) {
      return AppColors.error;
    } else {
      return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final statusColor = _getStatusColor();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, AppColors.grey50],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: statusColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  order.isPaid
                      ? Icons.check_circle_rounded
                      : order.isCanceled
                          ? Icons.cancel_rounded
                          : Icons.schedule_rounded,
                  size: 16.sp,
                  color: statusColor,
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    order.status?.localizedTitle(context) ??
                        AppLocalizations.of(context)!.unknown,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Информация о заказе
          _buildInfoRow(AppLocalizations.of(context)!.createdDate,
              dateFormat.format(order.createdAt)),
          if (order.paidAt != null)
            _buildInfoRow(AppLocalizations.of(context)!.paymentDate,
                dateFormat.format(order.paidAt!)),
          if (order.paidUntil != null && !order.isPaid)
            _buildInfoRow(
              AppLocalizations.of(context)!.payBefore,
              dateFormat.format(order.paidUntil!),
              valueColor: AppColors.warning,
            ),
          if (order.email != null) _buildInfoRow('Email', order.email!),
          if (order.phone != null)
            _buildInfoRow(AppLocalizations.of(context)!.phone, order.phone!),

          SizedBox(height: 16.h),

          // Итоговая сумма заказа
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalToPay,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${_formatPrice(order.totalPrice)} ₸',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Кнопка оплаты (для неоплаченных заказов)
          if (onPay != null) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onPay,
                icon: Icon(Icons.payment, size: 18.sp),
                label: Text(AppLocalizations.of(context)!.payOrder),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ],

          // Кнопки действий (Удалить для статуса 1, Отменить для статуса 2)
          if (onCancel != null || onDelete != null) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                if (onDelete != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onDelete,
                      icon: Icon(Icons.delete_outline, size: 18.sp),
                      label: Text(AppLocalizations.of(context)!.delete),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                if (onDelete != null && onCancel != null) SizedBox(width: 12.w),
                if (onCancel != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onCancel,
                      icon: Icon(Icons.cancel_outlined, size: 18.sp),
                      label: Text(AppLocalizations.of(context)!.cancel),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.warning,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Строит строку с информацией (label: value)
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                color: valueColor ?? AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Форматирует цену с разделителями тысяч
  String _formatPrice(double price) {
    return PriceFormatter.format(price);
  }
}

/// Виджет карточки товара в заказе
///
/// Отображает:
/// - Название продукта и варианта
/// - Количество и цену за единицу
/// - Статус товара
/// - Общую сумму
/// - Историю изменения статусов (в раскрывающейся секции)
class _OrderItemCard extends StatelessWidget {
  final ProductOrderItemEntity item;

  const _OrderItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final variant = item.variant;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.grey200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Кликабельная секция с информацией о продукте
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: product != null
                  ? () {
                      context.push(
                          '${AppRouteConstants.SingleProductPagePath}${product.id}');
                    }
                  : null,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Изображение продукта (заглушка)
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product?.localizedTitle(context) ??
                                      AppLocalizations.of(context)!.product,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (product != null) ...[
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14.sp,
                                  color: AppColors.primary,
                                ),
                              ],
                            ],
                          ),
                          if (variant != null) ...[
                            SizedBox(height: 4.h),
                            Text(
                              variant.localizedTitle(context) ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  '${AppLocalizations.of(context)!.quantity}: ${item.qty}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${_formatPrice(item.unitPrice)} ₸',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: const Divider(height: 1, color: AppColors.grey200),
          ),

          // Статус товара
          if (item.status != null) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getItemStatusColor(item).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _getItemStatusColor(item).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14.sp,
                      color: _getItemStatusColor(item),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        item.status?.localizedTitle(context) ?? '',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: _getItemStatusColor(item),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Общая сумма по товару
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.amount,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${_formatPrice(item.totalPrice)} ₸',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Секция истории изменения статусов товара
          if (item.historyRecords != null &&
              item.historyRecords!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 0),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.only(top: 8.h),
                title: Text(
                  AppLocalizations.of(context)!.statusHistory,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                children: item.historyRecords!.map((record) {
                  final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.grey200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              record.isPassed == true
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 14.sp,
                              color: record.isPassed == true
                                  ? AppColors.success
                                  : AppColors.grey400,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                record.localizedMessage(context) ?? '',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          dateFormat.format(record.createdAt),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  /// Определяет цвет статуса товара
  /// - Success (зеленый): товар оплачен
  /// - Error (красный): товар отменен
  /// - Warning (желтый): ожидает оплаты
  Color _getItemStatusColor(ProductOrderItemEntity item) {
    if (item.isPaid) {
      return AppColors.success;
    } else if (item.isCanceled) {
      return AppColors.error;
    } else {
      return AppColors.warning;
    }
  }

  /// Форматирует цену с разделителями тысяч
  String _formatPrice(double price) {
    return PriceFormatter.format(price);
  }
}
