import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/di/injection.dart';
import 'package:jankuier_mobile/core/services/firebase_notification_service.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_state.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_state.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_state.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_state.dart';
import 'package:jankuier_mobile/l10n/app_localizations.dart';

class MyNotificationPage extends StatefulWidget {
  const MyNotificationPage({super.key});

  @override
  State<MyNotificationPage> createState() => _MyNotificationPageState();
}

class _MyNotificationPageState extends State<MyNotificationPage>
    with SingleTickerProviderStateMixin {
  late GetFirebaseTokenBloc _getFirebaseTokenBloc;
  late CreateOrUpdateFirebaseTokenBloc _createOrUpdateFirebaseTokenBloc;
  late GetAllNotificationsBloc _newNotificationsBloc;
  late GetAllNotificationsBloc _readNotificationsBloc;
  late GetNotificationByIdBloc _getNotificationByIdBloc;
  late TabController _tabController;

  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeBlocs();
    _initializeFirebase();
  }

  void _initializeBlocs() {
    _getFirebaseTokenBloc = getIt<GetFirebaseTokenBloc>();
    _createOrUpdateFirebaseTokenBloc = getIt<CreateOrUpdateFirebaseTokenBloc>();
    _newNotificationsBloc = getIt<GetAllNotificationsBloc>();
    _readNotificationsBloc = getIt<GetAllNotificationsBloc>();
    _getNotificationByIdBloc = getIt<GetNotificationByIdBloc>();
  }

  Future<void> _initializeFirebase() async {
    final fcmToken = await FirebaseNotificationService.instance.getToken();
    if (fcmToken != null) {
      setState(() {
        _fcmToken = fcmToken;
      });

      _getFirebaseTokenBloc.add(const LoadFirebaseToken());
      _createOrUpdateFirebaseTokenBloc.add(
        CreateOrUpdateToken(
          FirebaseNotificationClientCreateParameter(
            token: fcmToken,
            isActive: true,
          ),
        ),
      );
    }

    _newNotificationsBloc.add(const LoadAllNotifications(
      NotificationPaginationParameter(perPage: 20, page: 1, isRead: false),
    ));

    _readNotificationsBloc.add(const LoadAllNotifications(
      NotificationPaginationParameter(perPage: 20, page: 1, isRead: true),
    ));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message);
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _newNotificationsBloc.add(const RefreshNotifications(
      NotificationPaginationParameter(perPage: 20, page: 1, isRead: false),
    ));

    if (message.notification != null && mounted) {
      _showFloatingNotification(message);
    }
  }

  void _showFloatingNotification(RemoteMessage message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Iconsax.notification_bing,
                  color: AppColors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.notification?.title ?? 'New notification',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: AppColors.white,
                      ),
                    ),
                    if (message.notification?.body != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        message.notification!.body!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
        elevation: 8,
        action: SnackBarAction(
          label: 'VIEW',
          textColor: AppColors.white,
          backgroundColor: Colors.white.withOpacity(0.2),
          onPressed: () {
            _tabController.animateTo(0);
            if (message.data['id'] != null) {
              final notificationId =
                  int.tryParse(message.data['id'].toString());
              if (notificationId != null) {
                _showNotificationDetails(notificationId);
              }
            }
          },
        ),
      ),
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    if (message.data['id'] != null) {
      final notificationId = int.tryParse(message.data['id'].toString());
      if (notificationId != null) {
        _showNotificationDetails(notificationId);
      }
    }
  }

  void _showNotificationDetails(int notificationId) {
    _getNotificationByIdBloc.add(LoadNotificationById(notificationId));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NotificationDetailModal(
        bloc: _getNotificationByIdBloc,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _getFirebaseTokenBloc.close();
    _createOrUpdateFirebaseTokenBloc.close();
    _newNotificationsBloc.close();
    _readNotificationsBloc.close();
    _getNotificationByIdBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _getFirebaseTokenBloc),
        BlocProvider.value(value: _createOrUpdateFirebaseTokenBloc),
        BlocProvider.value(value: _getNotificationByIdBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColors.grey50,
        body: CustomScrollView(
          slivers: [
            // Premium App Bar
            SliverAppBar(
              expandedHeight: 180.h,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Stack(
                    children: [
                      // Decorative circles
                      Positioned(
                        top: -50.h,
                        right: -50.w,
                        child: Container(
                          width: 200.w,
                          height: 200.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -30.h,
                        left: -30.w,
                        child: Container(
                          width: 150.w,
                          height: 150.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ),
                      // Content
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Notifications',
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  BlocBuilder<GetFirebaseTokenBloc,
                                      GetFirebaseTokenState>(
                                    builder: (context, state) {
                                      if (state is FirebaseTokenLoaded &&
                                          state.token != null) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.success
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            border: Border.all(
                                              color: AppColors.success
                                                  .withOpacity(0.5),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Iconsax.tick_circle,
                                                color: AppColors.white,
                                                size: 16.sp,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                'Active',
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Stay updated with latest news',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.grey600,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      dividerColor: Colors.transparent,
                      labelStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.notification,
                                  size: 18.sp),
                              SizedBox(width: 6.w),
                              const Text('New'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.archive_tick,
                                  size: 18.sp),
                              SizedBox(width: 6.w),
                              const Text('Read'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Tab Content
            SliverFillRemaining(
              child: Column(
                children: [
                  // Token Status
                  BlocBuilder<CreateOrUpdateFirebaseTokenBloc,
                      CreateOrUpdateFirebaseTokenState>(
                    builder: (context, state) {
                      if (state is CreateOrUpdateTokenSuccess) {
                        return Container(
                          margin: EdgeInsets.all(16.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.success.withOpacity(0.1),
                                AppColors.success.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.success.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.success.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Iconsax.tick_circle,
                                  color: AppColors.white,
                                  size: 22.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Push Notifications Enabled',
                                      style: TextStyle(
                                        color: AppColors.success,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'You\'ll receive all updates',
                                      style: TextStyle(
                                        color: AppColors.grey600,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // Tabs
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _NotificationsList(
                          bloc: _newNotificationsBloc,
                          isRead: false,
                          onNotificationTap: _showNotificationDetails,
                        ),
                        _NotificationsList(
                          bloc: _readNotificationsBloc,
                          isRead: true,
                          onNotificationTap: _showNotificationDetails,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper to get topic config
class _TopicConfig {
  final IconData icon;
  final Color color;
  final LinearGradient gradient;

  const _TopicConfig({
    required this.icon,
    required this.color,
    required this.gradient,
  });

  static _TopicConfig fromTopic(String? topicValue) {
    switch (topicValue?.toLowerCase()) {
      case 'alert':
        return _TopicConfig(
          icon: Iconsax.warning_2,
          color: const Color(0xFFF44336),
          gradient: LinearGradient(
            colors: [Color(0xFFF44336), Color(0xFFD32F2F)],
          ),
        );
      case 'news':
      case 'announcement':
        return _TopicConfig(
          icon: Iconsax.note_2,
          color: const Color(0xFF2196F3),
          gradient: AppColors.primaryGradient,
        );
      case 'promotion':
      case 'offer':
        return _TopicConfig(
          icon: Iconsax.tag,
          color: const Color(0xFFFF9800),
          gradient: LinearGradient(
            colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
          ),
        );
      case 'reminder':
        return _TopicConfig(
          icon: Iconsax.clock,
          color: const Color(0xFF9C27B0),
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
          ),
        );
      case 'success':
      case 'completed':
        return _TopicConfig(
          icon: Iconsax.tick_circle,
          color: AppColors.success,
          gradient: LinearGradient(
            colors: [AppColors.success, Color(0xFF388E3C)],
          ),
        );
      default:
        return _TopicConfig(
          icon: Iconsax.notification,
          color: AppColors.primary,
          gradient: AppColors.primaryGradient,
        );
    }
  }
}

class _NotificationsList extends StatefulWidget {
  final GetAllNotificationsBloc bloc;
  final bool isRead;
  final Function(int) onNotificationTap;

  const _NotificationsList({
    required this.bloc,
    required this.isRead,
    required this.onNotificationTap,
  });

  @override
  State<_NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<_NotificationsList> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    final state = widget.bloc.state;
    if (state is AllNotificationsLoaded) {
      final pagination = state.notifications;
      if (pagination.currentPage < pagination.lastPage) {
        setState(() {
          _isLoadingMore = true;
          _currentPage++;
        });

        widget.bloc.add(LoadAllNotifications(
          NotificationPaginationParameter(
            perPage: 20,
            page: _currentPage,
            isRead: widget.isRead,
          ),
        ));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocBuilder<GetAllNotificationsBloc, GetAllNotificationsState>(
        builder: (context, state) {
          if (state is AllNotificationsLoading && _currentPage == 1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Loading notifications...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.grey600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is AllNotificationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.danger,
                      size: 48.sp,
                      color: AppColors.error,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Oops! Something went wrong',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grey600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 1;
                      });
                      widget.bloc.add(LoadAllNotifications(
                        NotificationPaginationParameter(
                          perPage: 20,
                          page: 1,
                          isRead: widget.isRead,
                        ),
                      ));
                    },
                    icon: Icon(Iconsax.refresh, size: 20.sp),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 16.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is AllNotificationsLoaded) {
            final notifications = state.notifications.items;

            if (notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.grey200.withOpacity(0.5),
                            AppColors.grey100.withOpacity(0.5),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isRead
                            ? Iconsax.archive_tick
                            : Iconsax.notification_status,
                        size: 64.sp,
                        color: AppColors.grey400,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      widget.isRead ? 'No read notifications' : 'All caught up!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.isRead
                          ? 'You haven\'t read any notifications yet'
                          : 'You have no new notifications',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _currentPage = 1;
                });
                widget.bloc.add(RefreshNotifications(
                  NotificationPaginationParameter(
                    perPage: 20,
                    page: 1,
                    isRead: widget.isRead,
                  ),
                ));
              },
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: notifications.length + (_isLoadingMore ? 1 : 0),
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  if (index == notifications.length) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 3,
                        ),
                      ),
                    );
                  }

                  final notification = notifications[index];
                  return _PremiumNotificationCard(
                    notification: notification,
                    onTap: () => widget.onNotificationTap(notification.id),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _PremiumNotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const _PremiumNotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final topicConfig =
        _TopicConfig.fromTopic(notification.topic?.value);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey300.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              // Colored left border
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 5.w,
                  decoration: BoxDecoration(
                    gradient: topicConfig.gradient,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 8.w),

                    // Icon
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        gradient: topicConfig.gradient,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: topicConfig.color.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        topicConfig.icon,
                        color: AppColors.white,
                        size: 28.sp,
                      ),
                    ),

                    SizedBox(width: 16.w),

                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Topic label
                          if (notification.topic != null) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: topicConfig.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                notification.topic!.localizedTitle(context),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: topicConfig.color,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],

                          // Title
                          Text(
                            notification.localizedTitle(context),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 6.h),

                          // Description
                          Text(
                            notification.localizedDescription(context),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey600,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 12.h),

                          // Footer
                          Row(
                            children: [
                              Icon(
                                Iconsax.clock,
                                size: 14.sp,
                                color: AppColors.grey500,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _formatDateTime(notification.createdAt),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.grey500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Iconsax.arrow_right_3,
                                size: 18.sp,
                                color: topicConfig.color,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Active indicator
              if (notification.isActive)
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: topicConfig.color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: topicConfig.color.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class _NotificationDetailModal extends StatelessWidget {
  final GetNotificationByIdBloc bloc;

  const _NotificationDetailModal({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return BlocBuilder<GetNotificationByIdBloc,
                GetNotificationByIdState>(
              builder: (context, state) {
                if (state is NotificationByIdLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: 32.w,
                            height: 32.w,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Loading details...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.grey600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is NotificationByIdError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.danger,
                            size: 64.sp,
                            color: AppColors.error,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              color: AppColors.grey600,
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is NotificationByIdLoaded) {
                  final notification = state.notification;
                  final topicConfig =
                      _TopicConfig.fromTopic(notification.topic?.value);

                  return SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag handle
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

                        // Header with gradient
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            gradient: topicConfig.gradient,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: topicConfig.color.withOpacity(0.3),
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
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      topicConfig.icon,
                                      color: AppColors.white,
                                      size: 32.sp,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (notification.topic != null)
                                          Text(
                                            notification.topic!
                                                .localizedTitle(context)
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          notification.localizedTitle(context),
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w800,
                                            height: 1.2,
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

                        SizedBox(height: 24.h),

                        // Description Section
                        _SectionHeader(
                          icon: Iconsax.document_text,
                          title: 'Description',
                          color: topicConfig.color,
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.grey200,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            notification.localizedDescription(context),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Info Section
                        _SectionHeader(
                          icon: Iconsax.info_circle,
                          title: 'Information',
                          color: topicConfig.color,
                        ),
                        SizedBox(height: 12.h),
                        _InfoItem(
                          icon: Iconsax.calendar,
                          label: 'Created',
                          value: _formatFullDateTime(notification.createdAt),
                          color: topicConfig.color,
                        ),
                        SizedBox(height: 12.h),
                        _InfoItem(
                          icon: Iconsax.refresh_2,
                          label: 'Updated',
                          value: _formatFullDateTime(notification.updatedAt),
                          color: topicConfig.color,
                        ),

                        if (notification.actionUrl != null ||
                            notification.innerActionUrl != null) ...[
                          SizedBox(height: 32.h),
                          _SectionHeader(
                            icon: Iconsax.link,
                            title: 'Actions',
                            color: topicConfig.color,
                          ),
                          SizedBox(height: 12.h),
                        ],

                        if (notification.actionUrl != null)
                          _ActionButton(
                            icon: Iconsax.global,
                            label: 'Open Link',
                            subtitle: notification.actionUrl!,
                            gradient: topicConfig.gradient,
                            onTap: () {
                              // Handle URL
                            },
                          ),

                        if (notification.innerActionUrl != null) ...[
                          SizedBox(height: 12.h),
                          _ActionButton(
                            icon: Iconsax.arrow_right_1,
                            label: 'Navigate',
                            subtitle: notification.innerActionUrl!,
                            gradient: topicConfig.gradient,
                            onTap: () {
                              // Handle navigation
                            },
                          ),
                        ],

                        SizedBox(height: 32.h),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }

  String _formatFullDateTime(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
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
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: gradient.colors.first.withOpacity(0.05) == gradient.colors.first
              ? null
              : LinearGradient(
                  colors: [
                    gradient.colors.first.withOpacity(0.1),
                    gradient.colors.last.withOpacity(0.05),
                  ],
                ),
          color: gradient.colors.first.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: gradient.colors.first.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.white, size: 22.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              size: 20.sp,
              color: gradient.colors.first,
            ),
          ],
        ),
      ),
    );
  }
}
