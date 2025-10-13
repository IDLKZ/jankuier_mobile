import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import 'booking_webview_page.dart';
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
                content: AwesomeSnackbarContent(
                  title: AppLocalizations.of(context)!.success,
                  message: AppLocalizations.of(context)!
                      .bookingCancelledSuccessfully,
                  contentType: ContentType.success,
                ),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
              ),
            );
            _loadData(_tabController.index);
          } else if (state is DeleteMyFieldPartyRequestByIdError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: AppLocalizations.of(context)!.error,
                  message: state.message,
                  contentType: ContentType.warning,
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
            leadingIcon: Icons.arrow_back_ios_new,
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
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(8.r),
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
          borderRadius: BorderRadius.circular(8.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
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
        borderRadius: BorderRadius.circular(12.r),
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
                  booking.field?.localizedTitle(context) ??
                      AppLocalizations.of(context)!.field,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
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
                        booking.status?.localizedTitle(context) ??
                            AppLocalizations.of(context)!.status,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                _buildInfoRow(
                  Icons.calendar_today_rounded,
                  dateFormat.format(booking.startAt),
                  statusColor,
                ),
                SizedBox(height: 6.h),
                _buildInfoRow(
                  Icons.access_time_rounded,
                  '${timeFormat.format(booking.startAt)} - ${timeFormat.format(booking.endAt)}',
                  statusColor,
                ),
                SizedBox(height: 6.h),
                _buildInfoRow(
                  Icons.payments_rounded,
                  '${booking.totalPrice.toStringAsFixed(0)} ₸',
                  statusColor,
                ),
                if (booking.field?.localizedAddress(context) != null) ...[
                  SizedBox(height: 6.h),
                  _buildInfoRow(
                    Icons.location_on_rounded,
                    booking.field!.localizedAddress(context),
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
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<GetMyFieldPartyRequestByIdBloc,
              GetMyFieldPartyRequestByIdState>(
            builder: (context, state) {
              if (state is GetMyFieldPartyRequestByIdLoading) {
                return SizedBox(
                  height: 400.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor:
                              AlwaysStoppedAnimation(Colors.blue.shade600),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Загрузка...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final displayBooking = state is GetMyFieldPartyRequestByIdSuccess
                  ? state.request
                  : booking;

              final statusColor = _getStatusColor(displayBooking.statusId);

              return Column(
                children: [
                  // Handle
                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  // Header with status
                  Container(
                    margin: EdgeInsets.all(24.w),
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          statusColor.withOpacity(0.8),
                          statusColor.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                _getStatusIcon(displayBooking.statusId),
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Бронирование',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    displayBooking.status
                                            ?.localizedTitle(context) ??
                                        'Статус',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Main info cards
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildMainInfoCard(
                            icon: Icons.sports_soccer,
                            title: 'Поле',
                            value:
                                displayBooking.field?.localizedTitle(context) ??
                                    'Не указано',
                            color: Colors.blue.shade600,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildMainInfoCard(
                            icon: Icons.payments,
                            title: 'Стоимость',
                            value:
                                '${displayBooking.totalPrice.toStringAsFixed(0)} ₸',
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Date and time section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.purple.shade50,
                          Colors.blue.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.purple.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.purple.shade700,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Время бронирования',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Дата',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    dateFormat.format(displayBooking.startAt),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40.h,
                              color: Colors.purple.shade200,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Время',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${timeFormat.format(displayBooking.startAt)} - ${timeFormat.format(displayBooking.endAt)}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Additional info
                  if (displayBooking.field?.localizedAddress(context) != null ||
                      displayBooking.phone != null ||
                      displayBooking.email != null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дополнительная информация',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          if (displayBooking.field?.localizedAddress(context) !=
                              null)
                            _buildInfoTile(
                              icon: Icons.location_on,
                              title: 'Адрес',
                              value: displayBooking.field!
                                  .localizedAddress(context),
                              color: Colors.red.shade400,
                            ),
                          if (displayBooking.phone != null)
                            _buildInfoTile(
                              icon: Icons.phone,
                              title: 'Телефон',
                              value: displayBooking.phone!,
                              color: Colors.blue.shade400,
                            ),
                          if (displayBooking.email != null)
                            _buildInfoTile(
                              icon: Icons.email,
                              title: 'Email',
                              value: displayBooking.email!,
                              color: Colors.orange.shade400,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  // Purchase button
                  if (displayBooking.statusId == 1) ...[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        width: double.infinity,
                        height: 32.h,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gradientStart.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            final hiveUtils = getIt<HiveUtils>();
                            final token = await hiveUtils.getAccessToken();
                            if (token == null) {
                              context.go(AppRouteConstants.SignInPagePath);
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookingWebViewPage(
                                    bookingId: displayBooking.id.toString(),
                                    token: token,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 22.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                AppLocalizations.of(context)!.buyBooking,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],

                  // Cancel button
                  if (displayBooking.statusId == 1) ...[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      child: BlocBuilder<DeleteMyFieldPartyRequestByIdBloc,
                          DeleteMyFieldPartyRequestByIdState>(
                        builder: (context, deleteState) {
                          final isLoading = deleteState
                              is DeleteMyFieldPartyRequestByIdLoading;

                          return Container(
                            width: double.infinity,
                            height: 32.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.shade400,
                                  Colors.red.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => _showCancelDialog(
                                      context, displayBooking.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
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
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                          size: 22.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .cancelBooking,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  SizedBox(height: 24.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 14.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(int? statusId) {
    switch (statusId) {
      case 1:
        return Icons.schedule;
      case 2:
        return Icons.check_circle;
      case 3:
      case 4:
      case 5:
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getStatusColor(int? statusId) {
    switch (statusId) {
      case 1:
        return Colors.orange.shade600;
      case 2:
        return Colors.green.shade600;
      case 3:
      case 4:
      case 5:
        return Colors.red.shade600;
      default:
        return Colors.grey.shade500;
    }
  }

  void _showCancelDialog(BuildContext context, int bookingId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade600,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(context)!.cancelBookingTitle,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          AppLocalizations.of(context)!.cancelBookingConfirmation,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.no,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    context.read<DeleteMyFieldPartyRequestByIdBloc>().add(
                          DeleteMyFieldPartyRequestByIdStarted(id: bookingId),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.yesCancel,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
