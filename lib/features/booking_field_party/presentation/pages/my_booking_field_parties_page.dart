import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../data/entities/booking_field_party_request_entity.dart';
import '../../domain/parameters/booking_field_party_request_pagination_parameter.dart';
import '../bloc/delete_my_field_party_request_by_id/delete_my_field_party_request_by_id_bloc.dart';
import '../bloc/delete_my_field_party_request_by_id/delete_my_field_party_request_by_id_event.dart';
import '../bloc/delete_my_field_party_request_by_id/delete_my_field_party_request_by_id_state.dart';
import '../bloc/get_all_my_field_party_request/get_all_my_field_party_request_bloc.dart';
import '../bloc/get_all_my_field_party_request/get_all_my_field_party_request_event.dart';
import '../bloc/get_all_my_field_party_request/get_all_my_field_party_request_state.dart';
import '../bloc/get_my_field_party_request_by_id/get_my_field_party_request_by_id_bloc.dart';
import '../bloc/get_my_field_party_request_by_id/get_my_field_party_request_by_id_event.dart';
import '../bloc/get_my_field_party_request_by_id/get_my_field_party_request_by_id_state.dart';

class MyBookingFieldPartiesPage extends StatefulWidget {
  const MyBookingFieldPartiesPage({super.key});

  @override
  State<MyBookingFieldPartiesPage> createState() =>
      _MyBookingFieldPartiesPageState();
}

class _MyBookingFieldPartiesPageState extends State<MyBookingFieldPartiesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<int, int> _currentPages = {0: 1, 1: 1, 2: 1};
  final Map<int, ScrollController> _scrollControllers = {};

  late final GetAllMyFieldPartyRequestBloc _getAllMyFieldPartyRequestBloc;
  late final GetMyFieldPartyRequestByIdBloc _getMyFieldPartyRequestByIdBloc;
  late final DeleteMyFieldPartyRequestByIdBloc
      _deleteMyFieldPartyRequestByIdBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    for (int i = 0; i < 3; i++) {
      _scrollControllers[i] = ScrollController()
        ..addListener(() => _onScroll(i));
    }

    // Initialize BLoCs
    _getAllMyFieldPartyRequestBloc = getIt<GetAllMyFieldPartyRequestBloc>();
    _getMyFieldPartyRequestByIdBloc = getIt<GetMyFieldPartyRequestByIdBloc>();
    _deleteMyFieldPartyRequestByIdBloc =
        getIt<DeleteMyFieldPartyRequestByIdBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(0);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollControllers.forEach((_, controller) => controller.dispose());
    _getAllMyFieldPartyRequestBloc.close();
    _getMyFieldPartyRequestByIdBloc.close();
    _deleteMyFieldPartyRequestByIdBloc.close();
    super.dispose();
  }

  void _onScroll(int tabIndex) {
    final controller = _scrollControllers[tabIndex]!;
    if (controller.position.pixels >=
        controller.position.maxScrollExtent * 0.9) {
      _loadMoreData(tabIndex);
    }
  }

  void _loadData(int tabIndex) {
    final statusIds = _getStatusIdsForTab(tabIndex);
    _getAllMyFieldPartyRequestBloc.add(
      LoadAllMyFieldPartyRequest(
        BookingFieldPartyRequestPaginationParameter(
          statusIds: statusIds,
          page: 1,
          perPage: 12,
        ),
      ),
    );
    _currentPages[tabIndex] = 1;
  }

  void _loadMoreData(int tabIndex) {
    final state = _getAllMyFieldPartyRequestBloc.state;
    if (state is GetAllMyFieldPartyRequestSuccess) {
      if (state.pagination.hasNextPage) {
        final nextPage = (_currentPages[tabIndex] ?? 1) + 1;
        final statusIds = _getStatusIdsForTab(tabIndex);
        _getAllMyFieldPartyRequestBloc.add(
          LoadAllMyFieldPartyRequest(
            BookingFieldPartyRequestPaginationParameter(
              statusIds: statusIds,
              page: nextPage,
              perPage: 2,
            ),
            isLoadMore: true,
          ),
        );
        _currentPages[tabIndex] = nextPage;
      }
    }
  }

  List<int> _getStatusIdsForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return [1]; // Ожидает
      case 1:
        return [2]; // Оплачено
      case 2:
        return [3, 4, 5]; // Отменено
      default:
        return [1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _getAllMyFieldPartyRequestBloc),
        BlocProvider.value(value: _getMyFieldPartyRequestByIdBloc),
        BlocProvider.value(value: _deleteMyFieldPartyRequestByIdBloc),
      ],
      child: BlocListener<DeleteMyFieldPartyRequestByIdBloc,
          DeleteMyFieldPartyRequestByIdState>(
        listener: (context, state) {
          if (state is DeleteMyFieldPartyRequestByIdSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.bookingCancelledSuccessfully),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
            _loadData(_tabController.index);
          } else if (state is DeleteMyFieldPartyRequestByIdError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: PagesCommonAppBar(
            title: AppLocalizations.of(context)!.myBookings,
            actionIcon: Icons.sports_soccer,
            onActionTap: () {},
          ),
          body: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTabContent(0, AppColors.warning),
                    _buildTabContent(1, AppColors.success),
                    _buildTabContent(2, AppColors.error),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          _loadData(index);
        },
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        padding: EdgeInsets.all(4.w),
        tabs: [
          Tab(text: AppLocalizations.of(context)!.pending),
          Tab(text: AppLocalizations.of(context)!.paid),
          Tab(text: AppLocalizations.of(context)!.cancelled),
        ],
      ),
    );
  }

  Widget _buildTabContent(int tabIndex, Color statusColor) {
    return BlocBuilder<GetAllMyFieldPartyRequestBloc,
        GetAllMyFieldPartyRequestState>(
      builder: (context, state) {
        if (state is GetAllMyFieldPartyRequestLoading && !state.isLoadingMore) {
          return Center(
            child: CircularProgressIndicator(
              color: statusColor,
            ),
          );
        }

        if (state is GetAllMyFieldPartyRequestError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64.sp, color: AppColors.error),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => _loadData(tabIndex),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: statusColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.repeat),
                ),
              ],
            ),
          );
        }

        if (state is GetAllMyFieldPartyRequestSuccess) {
          final pagination = state.pagination;

          if (pagination.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 80.sp,
                    color: AppColors.grey400,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppLocalizations.of(context)!.noBookings,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _loadData(tabIndex);
            },
            color: statusColor,
            child: ListView.builder(
              controller: _scrollControllers[tabIndex],
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount:
                  pagination.items.length + (pagination.hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= pagination.items.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: CircularProgressIndicator(color: statusColor),
                    ),
                  );
                }

                final booking = pagination.items[index];
                return _buildBookingCard(booking, statusColor);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBookingCard(
      BookingFieldPartyRequestEntity booking, Color statusColor) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: statusColor.withOpacity(0.2),
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.08),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showBookingDetails(booking),
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.field?.localizedTitle(context) ?? AppLocalizations.of(context)!.field,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        statusColor.withOpacity(0.15),
                        statusColor.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: statusColor.withOpacity(0.25),
                      width: 1.5.w,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withOpacity(0.4),
                              blurRadius: 4.r,
                              spreadRadius: 1.r,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        booking.status?.localizedTitle(context) ?? AppLocalizations.of(context)!.status,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildInfoRow(
                  Icons.calendar_today_rounded,
                  dateFormat.format(booking.startAt),
                  statusColor,
                ),
                SizedBox(height: 10.h),
                _buildInfoRow(
                  Icons.access_time_rounded,
                  '${timeFormat.format(booking.startAt)} - ${timeFormat.format(booking.endAt)}',
                  statusColor,
                ),
                SizedBox(height: 10.h),
                _buildInfoRow(
                  Icons.payments_rounded,
                  '${booking.totalPrice.toStringAsFixed(0)} ₸',
                  statusColor,
                ),
                if (booking.field?.localizedAddress(context) != null) ...[
                  SizedBox(height: 10.h),
                  _buildInfoRow(
                    Icons.location_on_rounded,
                    booking.field!.localizedAddress(context)!,
                    statusColor,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: color,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }

  void _showBookingDetails(BookingFieldPartyRequestEntity booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: BlocProvider.value(
          value: _getMyFieldPartyRequestByIdBloc
            ..add(LoadMyFieldPartyRequestById(booking.id)),
          child: BlocProvider.value(
            value: _deleteMyFieldPartyRequestByIdBloc,
            child: _BookingDetailsBottomSheet(booking: booking),
          ),
        ),
      ),
    );
  }
}

class _BookingDetailsBottomSheet extends StatelessWidget {
  final BookingFieldPartyRequestEntity booking;

  const _BookingDetailsBottomSheet({required this.booking});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy', 'ru');
    final timeFormat = DateFormat('HH:mm');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<GetMyFieldPartyRequestByIdBloc,
              GetMyFieldPartyRequestByIdState>(
            builder: (context, state) {
              if (state is GetMyFieldPartyRequestByIdLoading) {
                return SizedBox(
                  height: 300.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final displayBooking = state is GetMyFieldPartyRequestByIdSuccess
                  ? state.request
                  : booking;

              final statusColor = _getStatusColor(displayBooking.statusId);

              return Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.grey300,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.bookingDetails,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 10.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              statusColor.withOpacity(0.2),
                              statusColor.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                            width: 1.5.w,
                          ),
                        ),
                        child: Text(
                          displayBooking.status?.localizedTitle(context) ??
                              AppLocalizations.of(context)!.status,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildDetailCard(
                      context: context,
                      icon: Icons.stadium,
                      title: AppLocalizations.of(context)!.field,
                      value: displayBooking.field?.localizedTitle(context) ??
                          AppLocalizations.of(context)!.notSpecified,
                      statusColor: statusColor,
                    ),
                    SizedBox(height: 12.h),
                    _buildDetailCard(
                      context: context,
                      icon: Icons.calendar_today,
                      title: AppLocalizations.of(context)!.date,
                      value: dateFormat.format(displayBooking.startAt),
                      statusColor: statusColor,
                    ),
                    SizedBox(height: 12.h),
                    _buildDetailCard(
                      context: context,
                      icon: Icons.access_time,
                      title: AppLocalizations.of(context)!.time,
                      value:
                          '${timeFormat.format(displayBooking.startAt)} - ${timeFormat.format(displayBooking.endAt)}',
                      statusColor: statusColor,
                    ),
                    SizedBox(height: 12.h),
                    _buildDetailCard(
                      context: context,
                      icon: Icons.attach_money,
                      title: AppLocalizations.of(context)!.total,
                      value:
                          '${displayBooking.totalPrice.toStringAsFixed(0)} ₸',
                      statusColor: statusColor,
                    ),
                    if (displayBooking.field?.localizedAddress(context) !=
                        null) ...[
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        context: context,
                        icon: Icons.location_on,
                        title: AppLocalizations.of(context)!.address,
                        value: displayBooking.field!.localizedAddress(context)!,
                        statusColor: statusColor,
                      ),
                    ],
                    if (displayBooking.phone != null) ...[
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        context: context,
                        icon: Icons.phone,
                        title: AppLocalizations.of(context)!.phone,
                        value: displayBooking.phone!,
                        statusColor: statusColor,
                      ),
                    ],
                    if (displayBooking.email != null) ...[
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        context: context,
                        icon: Icons.email,
                        title: AppLocalizations.of(context)!.email,
                        value: displayBooking.email!,
                        statusColor: statusColor,
                      ),
                    ],
                    if (displayBooking.statusId == 1) ...[
                      SizedBox(height: 24.h),
                      BlocBuilder<DeleteMyFieldPartyRequestByIdBloc,
                          DeleteMyFieldPartyRequestByIdState>(
                        builder: (context, deleteState) {
                          final isLoading = deleteState
                              is DeleteMyFieldPartyRequestByIdLoading;

                          return SizedBox(
                            width: double.infinity,
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => _showCancelDialog(
                                      context, displayBooking.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                                disabledBackgroundColor:
                                    AppColors.error.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                elevation: 0,
                              ),
                              child: isLoading
                                  ? SizedBox(
                                      width: 24.w,
                                      height: 24.h,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cancel,
                                          size: 20.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          AppLocalizations.of(context)!.cancelBooking,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                    SizedBox(height: 16.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color statusColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.grey200,
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: statusColor,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(int? statusId) {
    switch (statusId) {
      case 1:
        return AppColors.warning;
      case 2:
        return AppColors.success;
      case 3:
      case 4:
      case 5:
        return AppColors.error;
      default:
        return AppColors.grey500;
    }
  }

  void _showCancelDialog(BuildContext context, int bookingId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.warning,
              size: 28.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              AppLocalizations.of(context)!.cancelBookingTitle,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Text(
          AppLocalizations.of(context)!.cancelBookingConfirmation,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              AppLocalizations.of(context)!.no,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<DeleteMyFieldPartyRequestByIdBloc>().add(
                    DeleteMyFieldPartyRequestByIdStarted(id: bookingId),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.yesCancel,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
