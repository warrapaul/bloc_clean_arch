import 'dart:convert';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/firebase/models/notification_payload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Configuration class for notification channels
class NotificationChannelConfig {
  static const androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
}

// Top-level background handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final notificationService = FirebaseNotificationService.instance;
  await notificationService.handleBackgroundMessage(message);
}

class FirebaseNotificationService {
  static FirebaseNotificationService? _instance;
  static FirebaseNotificationService get instance =>
      _instance ??= FirebaseNotificationService._();

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  // Private constructor
  FirebaseNotificationService._();

  // Setup notifications
  Future<void> setup() async {
    try {
      await _setupPermissions();
      await _setupLocalNotifications();
      await _setupFirebaseMessaging();
      await _setupNotificationHandlers();
    } catch (e, stack) {
      debugPrint('Error setting up notifications: $e');
      debugPrint(stack.toString());
    }
  }

  // Permission setup
  Future<void> _setupPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint(
        'Notification permission status: ${settings.authorizationStatus}');
  }

  // Local notifications setup
  Future<void> _setupLocalNotifications() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(NotificationChannelConfig.androidChannel);
  }

  // Firebase messaging setup
  Future<void> _setupFirebaseMessaging() async {
    final token = await _firebaseMessaging.getToken();
    logger.d('FCM token: $token');
    await _saveTokenToPrefs(token);

    _firebaseMessaging.onTokenRefresh.listen(_saveTokenToPrefs);
  }

  // Setup notification handlers
  Future<void> _setupNotificationHandlers() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpen);
    await _handleInitialMessage();
  }

  // Handle background message
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await _showLocalNotification(
      NotificationPayload.fromMessage(message),
    );
    await _saveNotificationToPrefs(message);
  }

  // Handle foreground message
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    await _showLocalNotification(
      NotificationPayload.fromMessage(message),
    );
  }

  // Handle notification open
  void _handleNotificationOpen(RemoteMessage message) {
    _navigateToNotificationScreen(
      NotificationPayload.fromMessage(message),
    );
  }

  // Handle initial message
  Future<void> _handleInitialMessage() async {
    final message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      _navigateToNotificationScreen(
        NotificationPayload.fromMessage(message),
      );
    }
  }

  // Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final payload = jsonDecode(response.payload!);
      _navigateToNotificationScreen(
        NotificationPayload(
          title: payload['title'],
          body: payload['body'],
          data: payload['data'],
        ),
      );
    }
  }

  // Show local notification
  Future<void> _showLocalNotification(NotificationPayload payload) async {
    await _localNotifications.show(
      payload.hashCode,
      payload.title,
      payload.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannelConfig.androidChannel.id,
          NotificationChannelConfig.androidChannel.name,
          channelDescription:
              NotificationChannelConfig.androidChannel.description,
        ),
      ),
      payload: jsonEncode(payload.toJson()),
    );
  }

  // Navigate to notification screen
  void _navigateToNotificationScreen(NotificationPayload payload) {
    // AppRouter2.router.go('/test2/123');
    AppRouter.router.go(
      AppRoutePaths.notifications,
      extra: {
        'title': payload.title ?? 'test title',
        'body': payload.body ?? 'test body',
        'data': payload.data ?? {'name': 'user', 'age': 20},
      },
    );
  }

// void _navigateToNotificationScreen(NotificationPayload payload) {
//   final authCubit = GetIt.instance<AuthCubit>();
//   final bool isAuthenticated = authCubit.state is AuthenticatedState;

//   if (isAuthenticated) {
//     AppRouter.router.go(
//       AppRoutePaths.notifications,
//       extra: {
//         'title': payload.title ?? 'Default Title',
//         'body': payload.body ?? 'Default Body',
//         'data': payload.data ?? {'name': 'user', 'age': 20},
//       },
//     );
//   } else {
//     // Redirect to login if the user is not authenticated
//     AppRouter.router.go(AppRoutePaths.login);
//   }
// }

  // Save token to preferences
  Future<void> _saveTokenToPrefs(String? token) async {
    if (token == null) return;

    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('fcm_token', token);
    debugPrint('FCM Token saved: $token');
    // logger.d('FCM Token: $fCMToken');

  }

  // Save notification to preferences
  Future<void> _saveNotificationToPrefs(RemoteMessage message) async {
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final notifications = prefs.getStringList('notifications') ?? [];

      // final notification = {
      //   'id': message.messageId,
      //   'title': message.notification?.title,
      //   'body': message.notification?.body,
      //   'data': message.data,
      //   'timestamp': DateTime.now().toIso8601String(),
      // };

      // notifications.add(jsonEncode(notification));

      // if (notifications.length > 20) {
      //   notifications.removeAt(0);
      // }

      // await prefs.setStringList('notifications', notifications);
    } catch (e) {
      debugPrint('Error saving notification: $e');
    }
  }
}