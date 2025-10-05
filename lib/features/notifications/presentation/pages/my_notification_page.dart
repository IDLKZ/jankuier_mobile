import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/di/injection.dart';
import 'package:jankuier_mobile/core/services/firebase_notification_service.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/l10n/app_localizations.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_state.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_state.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_bloc.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_state.dart';

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
  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;

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
    // Check if user is logged in
    final hiveUtils = getIt<HiveUtils>();
    final currentUser = await hiveUtils.getCurrentUser();

    if (currentUser == null) {
      // User not logged in, don't initialize notifications
      return;
    }

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

    // Subscribe to Firebase messages and save subscriptions
    _onMessageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (mounted) {
        _handleForegroundMessage(message);
      }
    });

    _onMessageOpenedAppSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (mounted) {
        _handleNotificationTap(message);
      }
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    if (!mounted) return;

    _newNotificationsBloc.add(const RefreshNotifications(
      NotificationPaginationParameter(perPage: 20, page: 1, isRead: false),
    ));

    if (message.notification != null) {
      _showFloatingNotification(message);
    }
  }

  void _showFloatingNotification(RemoteMessage message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 16.w,
        right: 16.w,
        child: Material(
          color: Colors.transparent,
          child: _NotificationSnackbar(
            message: message,
            onTap: () {
              overlayEntry.remove();
              _tabController.animateTo(0);
              if (message.data['id'] != null) {
                final notificationId =
                    int.tryParse(message.data['id'].toString());
                if (notificationId != null) {
                  _showNotificationDetails(notificationId);
                }
              }
            },
            onDismiss: () {
              overlayEntry.remove();
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 5), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    if (!mounted) return;

    if (message.data['id'] != null) {
      final notificationId = int.tryParse(message.data['id'].toString());
      if (notificationId != null) {
        _showNotificationDetails(notificationId);
      }
    }
  }

  void _showNotificationDetails(int notificationId) {
    if (!mounted) return;

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
    // Cancel Firebase message subscriptions first
    _onMessageSubscription?.cancel();
    _onMessageOpenedAppSubscription?.cancel();

    // Then dispose other resources
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
        backgroundColor: AppColors.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 140.h,
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.of(context).pop(),
                color: AppColors.white,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  AppLocalizations.of(context)!.notifications,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                AutoSizeText(
                                  maxLines: 1,
                                  AppLocalizations.of(context)!.stayUpdated,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.white.withOpacity(0.85),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<GetFirebaseTokenBloc,
                              GetFirebaseTokenState>(
                            builder: (context, state) {
                              if (state is FirebaseTokenLoaded &&
                                  state.token != null) {
                                return Container(
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Iconsax.tick_circle,
                                        color: AppColors.white,
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        AppLocalizations.of(context)!.active,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 11.sp,
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
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(56.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.grey600,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      dividerColor: Colors.transparent,
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.notification, size: 16.sp),
                              SizedBox(width: 6.w),
                              Text(AppLocalizations.of(context)!
                                  .newNotifications),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.archive_tick, size: 16.sp),
                              SizedBox(width: 6.w),
                              Text(AppLocalizations.of(context)!
                                  .readNotifications),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
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
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
            );
          }

          if (state is AllNotificationsError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.danger,
                      size: 56.sp,
                      color: AppColors.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      AppLocalizations.of(context)!.somethingWentWrong,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.grey600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.tryAgain),
                    ),
                  ],
                ),
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
                    Icon(
                      widget.isRead
                          ? Iconsax.archive_tick
                          : Iconsax.notification_status,
                      size: 64.sp,
                      color: AppColors.grey400,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      widget.isRead
                          ? AppLocalizations.of(context)!.noReadNotifications
                          : AppLocalizations.of(context)!.allCaughtUp,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      widget.isRead
                          ? AppLocalizations.of(context)!.noReadNotificationsYet
                          : AppLocalizations.of(context)!.noNewNotifications,
                      style: TextStyle(
                        fontSize: 13.sp,
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: notifications.length + (_isLoadingMore ? 1 : 0),
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
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
    final topicConfig = _TopicConfig.fromTopic(notification.topic?.value);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.grey200,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              // Icon
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  gradient: topicConfig.gradient,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  topicConfig.icon,
                  color: AppColors.white,
                  size: 22.sp,
                ),
              ),

              SizedBox(width: 12.w),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topic label & Title
                    Row(
                      children: [
                        if (notification.topic != null) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: topicConfig.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              notification.topic!.localizedTitle(context),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: topicConfig.color,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                        ],
                        Expanded(
                          child: Text(
                            _formatDateTime(notification.createdAt, context),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.grey500,
                            ),
                          ),
                        ),
                        if (notification.isActive)
                          _PulsingDot(color: topicConfig.color),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Title
                    Text(
                      notification.localizedTitle(context),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 3.h),

                    // Description
                    Text(
                      notification.localizedDescription(context),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              Icon(
                Iconsax.arrow_right_3,
                size: 16.sp,
                color: AppColors.grey400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final localizations = AppLocalizations.of(context)!;

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return localizations.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return localizations.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return localizations.minutesAgo(difference.inMinutes);
    } else {
      return localizations.justNow;
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
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return BlocBuilder<GetNotificationByIdBloc,
                GetNotificationByIdState>(
              builder: (context, state) {
                if (state is NotificationByIdLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 3,
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
                            size: 56.sp,
                            color: AppColors.error,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            AppLocalizations.of(context)!.error,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              color: AppColors.grey600,
                              fontSize: 13.sp,
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
                    padding: EdgeInsets.all(20.w),
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

                        SizedBox(height: 20.h),

                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                gradient: topicConfig.gradient,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                topicConfig.icon,
                                color: AppColors.white,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (notification.topic != null)
                                    Text(
                                      notification.topic!
                                          .localizedTitle(context)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: topicConfig.color,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    notification.localizedTitle(context),
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Description
                        Text(
                          notification.localizedDescription(context),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Info
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _CompactInfoItem(
                                  icon: Iconsax.calendar,
                                  label: AppLocalizations.of(context)!.created,
                                  value: _formatFullDateTime(
                                      notification.createdAt),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 32.h,
                                color: AppColors.grey200,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _CompactInfoItem(
                                  icon: Iconsax.refresh_2,
                                  label: AppLocalizations.of(context)!.updated,
                                  value: _formatFullDateTime(
                                      notification.updatedAt),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (notification.actionUrl != null ||
                            notification.innerActionUrl != null) ...[
                          SizedBox(height: 16.h),
                          if (notification.actionUrl != null)
                            _CompactActionButton(
                              icon: Iconsax.global,
                              label: AppLocalizations.of(context)!.openLink,
                              color: topicConfig.color,
                              onTap: () {
                                // Handle URL
                              },
                            ),
                          if (notification.innerActionUrl != null) ...[
                            SizedBox(height: 8.h),
                            _CompactActionButton(
                              icon: Iconsax.arrow_right_1,
                              label: AppLocalizations.of(context)!.navigate,
                              color: topicConfig.color,
                              onTap: () {
                                // Handle navigation
                              },
                            ),
                          ],
                        ],

                        SizedBox(height: 20.h),
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

class _CompactInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CompactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14.sp, color: AppColors.grey500),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.grey600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _CompactActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CompactActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(_animation.value),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(_animation.value * 0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NotificationSnackbar extends StatefulWidget {
  final RemoteMessage message;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationSnackbar({
    required this.message,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  State<_NotificationSnackbar> createState() => _NotificationSnackbarState();
}

class _NotificationSnackbarState extends State<_NotificationSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0 || details.primaryVelocity! < 0) {
              _dismiss();
            }
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.white,
                  AppColors.white.withOpacity(0.95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // App Icon with logo
                Container(
                  width: 48.w,
                  height: 48.w,
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
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        'assets/images/logo_white.png',
                        width: 32.w,
                        height: 32.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.message.notification?.title ??
                                  AppLocalizations.of(context)!.newNotification,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _PulsingDot(color: AppColors.primary),
                        ],
                      ),
                      if (widget.message.notification?.body != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          widget.message.notification!.body!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.grey600,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.justNow,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.grey500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            AppLocalizations.of(context)!.tapToView,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                // Close button
                GestureDetector(
                  onTap: _dismiss,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: AppColors.grey600,
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
}
