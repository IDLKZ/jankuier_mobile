import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_ticketon_order_parameter.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/paginate_ticket_order/paginate_ticket_order_bloc.dart';
import 'package:jankuier_mobile/features/ticket/presentation/widgets/qr_code_bottom_sheet.dart';
import 'package:jankuier_mobile/features/ticket/presentation/widgets/ticket_order_card.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/entities/ticket_order/ticket_order_entity.dart';
import '../bloc/paginate_ticket_order/paginate_ticket_order_event.dart';
import '../bloc/paginate_ticket_order/paginate_ticket_order_state.dart';
import 'order_details_bottom_sheet.dart';

class MyTicketsWidget extends StatefulWidget {
  const MyTicketsWidget({super.key});

  @override
  State<MyTicketsWidget> createState() => _MyTicketsWidgetState();
}

class _MyTicketsWidgetState extends State<MyTicketsWidget> {
  late final PaginateTicketOrderBloc _bloc;
  bool isAuthenticated = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<PaginateTicketOrderBloc>();
    _checkAuthentication();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Проверяем авторизацию при каждом возврате на экран
    _checkAuthenticationAndRefresh();
  }

  Future<void> _checkAuthentication() async {
    try {
      final hiveUtils = getIt<HiveUtils>();
      final token = await hiveUtils.getAccessToken();

      if (mounted) {
        setState(() {
          isAuthenticated = token != null && token.isNotEmpty;
          isLoading = false;
        });

        if (isAuthenticated) {
          _bloc.add(RefreshTicketOrderEvent(myTicketParameter));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isAuthenticated = false;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _checkAuthenticationAndRefresh() async {
    try {
      final hiveUtils = getIt<HiveUtils>();
      final token = await hiveUtils.getAccessToken();
      final wasAuthenticated = isAuthenticated;

      if (mounted) {
        setState(() {
          isAuthenticated = token != null && token.isNotEmpty;
          isLoading = false;
        });

        // Обновляем данные только если статус авторизации изменился на "авторизован"
        // или если пользователь уже был авторизован (для refresh при возврате на экран)
        if (isAuthenticated && (!wasAuthenticated || wasAuthenticated)) {
          _bloc.add(RefreshTicketOrderEvent(myTicketParameter));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isAuthenticated = false;
          isLoading = false;
        });
      }
    }
  }

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
      builder: (context) => SafeArea(
        child: OrderDetailsBottomSheet(
          order: order,
          onShowQRCode: () => _showQRCodeBottomSheet(context, order),
        ),
      ),
    );
  }

  void _showQRCodeBottomSheet(BuildContext context, TicketonOrderEntity order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: QRCodeBottomSheet(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!isAuthenticated) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.user_add_copy,
                size: 64.sp,
                color: AppColors.grey300,
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context)!.pleaseAuthorize,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  context.go(AppRouteConstants.SignInPagePath);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 12.h,
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider.value(
      value: _bloc,
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
                    AppLocalizations.of(context)!.youHaveNoOrdersYet,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppLocalizations.of(context)!.orderedTicketsWillAppearHere,
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
              _bloc.add(RefreshTicketOrderEvent(myTicketParameter));
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
          return const Center(
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
                  AppLocalizations.of(context)!.loadingError,
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
                    _bloc.add(RefreshTicketOrderEvent(myTicketParameter));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(AppLocalizations.of(context)!.retry),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}