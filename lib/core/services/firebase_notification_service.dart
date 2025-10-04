import 'dart:convert';
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Top-level function for handling background messages
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling background message: ${message.messageId}');
  }

  // Show local notification for background messages
  await FirebaseNotificationService.instance.showLocalNotification(message);
}

class FirebaseNotificationService {
  static final FirebaseNotificationService instance =
      FirebaseNotificationService._internal();

  factory FirebaseNotificationService() => instance;

  FirebaseNotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Notification channels
  static const AndroidNotificationChannel _defaultChannel =
      AndroidNotificationChannel(
    'jankuier_notifications', // id
    'Jankuier Notifications', // name
    description: 'General notifications from Jankuier app',
    importance: Importance.high,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  static const AndroidNotificationChannel _importantChannel =
      AndroidNotificationChannel(
    'jankuier_important', // id
    'Important Notifications', // name
    description: 'Important notifications that require immediate attention',
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  /// Initialize the notification service
  Future<void> initialize() async {
    // Request permissions for iOS
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Notification permission granted: ${settings.authorizationStatus}');
    }

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Setup message handlers
    await _setupMessageHandlers();

    // Create notification channels for Android
    await _createNotificationChannels();
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _createNotificationChannels() async {
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_defaultChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_importantChannel);
  }

  Future<void> _setupMessageHandlers() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Foreground message received: ${message.messageId}');
      }
      showLocalNotification(message);
    });

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Notification opened app: ${message.messageId}');
      }
      _handleNotificationNavigation(message);
    });

    // Check if app was opened from a terminated state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      if (kDebugMode) {
        print('App opened from terminated state: ${initialMessage.messageId}');
      }
      _handleNotificationNavigation(initialMessage);
    }
  }

  /// Show local notification
  Future<void> showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    if (notification == null) return;

    // Determine channel based on priority
    final isImportant =
        data['priority'] == 'high' || data['priority'] == 'urgent';
    final channel = isImportant ? _importantChannel : _defaultChannel;

    // Extract image URL if available
    final imageUrl =
        notification.android?.imageUrl ?? notification.apple?.imageUrl;

    // Build notification details
    final androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: channel.importance,
      priority: isImportant ? Priority.max : Priority.high,
      enableVibration: true,
      playSound: true,
      styleInformation: imageUrl != null
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(imageUrl),
              contentTitle: notification.title,
              summaryText: notification.body,
              htmlFormatContentTitle: true,
              htmlFormatSummaryText: true,
            )
          : BigTextStyleInformation(
              notification.body ?? '',
              contentTitle: notification.title,
              htmlFormatBigText: true,
              htmlFormatContentTitle: true,
            ),
      color: const Color(0xFF0249CC), // AppColors.primary
      ledColor: const Color(0xFF0249CC),
      ledOnMs: 1000,
      ledOffMs: 500,
      ticker: notification.title,
      showWhen: true,
      when: DateTime.now().millisecondsSinceEpoch,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
      threadIdentifier: 'jankuier_notifications',
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Show notification
    await _localNotifications.show(
      message.messageId.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: jsonEncode(data),
    );
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _handleNotificationNavigation(
        RemoteMessage(
          data: Map<String, dynamic>.from(data),
        ),
      );
    }
  }

  /// Handle navigation when notification is tapped
  void _handleNotificationNavigation(RemoteMessage message) {
    final data = message.data;

    // You can implement custom navigation logic here
    if (kDebugMode) {
      print('Navigate to: ${data['screen'] ?? 'notifications'}');
      print('Notification data: $data');
    }

    // Example navigation logic:
    // - data['screen'] = 'notification_details', data['id'] = '123'
    // - data['screen'] = 'profile'
    // - data['action_url'] = 'https://example.com'
    // - data['inner_action_url'] = '/services/field/123'
  }

  /// Get FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    if (kDebugMode) {
      print('Subscribed to topic: $topic');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    if (kDebugMode) {
      print('Unsubscribed from topic: $topic');
    }
  }

  /// Show custom local notification (for testing or manual notifications)
  Future<void> showCustomNotification({
    required String title,
    required String body,
    String? payload,
    bool isImportant = false,
  }) async {
    final channel = isImportant ? _importantChannel : _defaultChannel;

    final androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: channel.importance,
      priority: isImportant ? Priority.max : Priority.high,
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
      ),
      color: const Color(0xFF0249CC),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  /// Get active notifications
  Future<List<ActiveNotification>> getActiveNotifications() async {
    final android = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (android != null) {
      return await android.getActiveNotifications();
    }

    return [];
  }
}
