import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';
import '../../domain/parameters/product_order_pagination_parameter.dart';
import '../bloc/get_my_product_orders/get_my_product_orders_bloc.dart';
import '../bloc/get_my_product_orders/get_my_product_orders_event.dart';
import '../bloc/get_my_product_orders/get_my_product_orders_state.dart';
import '../../../../l10n/app_localizations.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GetMyProductOrdersBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  List<int> _currentStatusIds = [1];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _bloc = getIt<GetMyProductOrdersBloc>();

    // Load initial data for the first tab
    _loadOrders([1], reset: true);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreOrders();
    }
  }

  void _onTabChanged(int index) {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    switch (index) {
      case 0: // Ожидают оплаты
        _loadOrders([1], reset: true);
        break;
      case 1: // Оплачено
        _loadOrders([2], reset: true);
        break;
      case 2: // Отмененные
        _loadOrders([3, 4, 5], reset: true);
        break;
    }
  }

  void _loadOrders(List<int> statusIds, {bool reset = false}) {
    if (reset) {
      _currentPage = 1;
      _currentStatusIds = statusIds;
    }

    _bloc.add(LoadMyProductOrders(
      ProductOrderPaginationParameter(
        statusIds: statusIds,
        perPage: 20,
        page: _currentPage,
      ),
    ));
  }

  void _loadMoreOrders() {
    final currentState = _bloc.state;
    if (currentState is GetMyProductOrdersLoaded && !_isLoadingMore) {
      final pagination = currentState.orders;
      if (_currentPage < pagination.totalPages) {
        setState(() {
          _isLoadingMore = true;
          _currentPage++;
        });
        _loadOrders(_currentStatusIds);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PagesCommonAppBar(
        title: AppLocalizations.of(context)!.myOrders,
        actionIcon: Icons.add_shopping_cart,
        onActionTap: () {},
        leadingIcon: Icons.arrow_back_ios_new,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withAlpha(1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(5.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.grey500,
              labelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(text: AppLocalizations.of(context)!.awaitingPayment),
                Tab(text: AppLocalizations.of(context)!.paid),
                Tab(text: AppLocalizations.of(context)!.cancelled),
              ],
            ),
          ),
          Expanded(
            child: BlocProvider.value(
              value: _bloc,
              child:
                  BlocBuilder<GetMyProductOrdersBloc, GetMyProductOrdersState>(
                builder: (context, state) {
                  if (state is GetMyProductOrdersLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  }

                  if (state is GetMyProductOrdersError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.sp,
                            color: colorScheme.error,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            AppLocalizations.of(context)!.loadingError,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () =>
                                _onTabChanged(_tabController.index),
                            icon: const Icon(Icons.refresh),
                            label: Text(AppLocalizations.of(context)!.repeat),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is GetMyProductOrdersLoaded) {
                    final List<ProductOrderEntity> orders =
                        state.orders.items ?? [];
                    _isLoadingMore = false;

                    if (orders.isEmpty && _currentPage == 1) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 80.sp,
                              color:
                                  colorScheme.onSurfaceVariant.withOpacity(0.5),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              AppLocalizations.of(context)!.noOrdersYet,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              AppLocalizations.of(context)!
                                  .placeFirstOrderInShop,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        _onTabChanged(_tabController.index);
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        itemCount: orders.length +
                            (_currentPage < state.orders.totalPages ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= orders.length) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.h),
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          }

                          final order = orders[index];
                          return _OrderCard(
                            order: order,
                            onTap: () {
                              context.push(
                                  '${AppRouteConstants.MySingleProductOrderPagePath}${order.id}');
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final ProductOrderEntity order;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final statusColor = _getStatusColor(order);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            AppColors.grey50,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.receipt_long_rounded,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.order} ${order.id}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 11.sp,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: Text(
                                  dateFormat.format(order.createdAt),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),

                // Price Section
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.15),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.payments_rounded,
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8.w),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!.total,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          '${_formatPrice(order.totalPrice)} ₸',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                            letterSpacing: -0.3,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                if (order.isPaid != null) ...[
                  SizedBox(height: 10.h),
                  _buildInfoChip(
                    icon: Icons.check_circle_rounded,
                    label: AppLocalizations.of(context)!.paidOn,
                    value: dateFormat.format(order.paidAt ?? DateTime.now()),
                    color: AppColors.primary,
                  ),
                ],

                if (order.paidUntil != null && !order.isPaid) ...[
                  SizedBox(height: 10.h),
                  _buildInfoChip(
                    icon: Icons.schedule_rounded,
                    label: AppLocalizations.of(context)!.payBefore,
                    value: dateFormat.format(order.paidUntil ?? DateTime.now()),
                    color: AppColors.primary,
                  ),
                ],

                SizedBox(height: 12.h),

                // Status Badge (moved to bottom)
                _buildStatusBadge(context, order),

                SizedBox(height: 12.h),

                // Action Button
                Container(
                  width: double.infinity,
                  height: 42.h,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.details,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ProductOrderEntity order) {
    if (order.isPaid) {
      return AppColors.success;
    } else if ([3, 4, 5].contains(order.statusId)) {
      return AppColors.error;
    } else {
      return AppColors.warning;
    }
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: color,
          ),
          SizedBox(width: 7.w),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 11.sp,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11.sp,
                color: color.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, ProductOrderEntity order) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    String statusText;

    if (order.status != null) {
      statusText = order.status?.localizedTitle(context) ??
          AppLocalizations.of(context)!.unknown;
    } else {
      statusText = AppLocalizations.of(context)!.unknown;
    }

    if (order.isPaid && [2].contains(order.statusId)) {
      backgroundColor = AppColors.success;
      textColor = Colors.white;
      icon = Icons.check_circle_rounded;
    } else if ([3, 4, 5].contains(order.statusId)) {
      backgroundColor = AppColors.error;
      textColor = Colors.white;
      icon = Icons.cancel_rounded;
    } else {
      backgroundColor = AppColors.warning;
      textColor = Colors.white;
      icon = Icons.schedule_rounded;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: backgroundColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 15.sp,
            color: backgroundColor,
          ),
          SizedBox(width: 7.w),
          Flexible(
            child: Text(
              statusText,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: backgroundColor,
                letterSpacing: 0.1,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,##0.00', 'ru_RU');
    return formatter.format(price);
  }
}
