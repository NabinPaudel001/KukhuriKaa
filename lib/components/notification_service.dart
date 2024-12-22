import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// -------------------------------------------------
// Initialize Flutter Local Notifications Plugin
// -------------------------------------------------
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// -------------------------------------------------
// Initialize Notification Settings
// -------------------------------------------------
Future<void> initializeNotifications() async {
  // Android notification settings
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Notification settings (other platforms like iOS can be added here)
  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );

  try {
    await flutterLocalNotificationsPlugin.initialize(settings);
  } catch (e) {
    print("Error initializing notifications: $e");
  }
}

// -------------------------------------------------
// Create Notification Channel for Android 8.0+
// -------------------------------------------------
Future<void> createNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'default_channel', // ID
    'Default Channel', // Name
    description: 'This is the default notification channel',
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
    playSound: true,
  );

  try {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  } catch (e) {
    print("Error creating notification channel: $e");
  }
}

// -------------------------------------------------
// Show Notification with Custom Title and Body
// -------------------------------------------------
Future<void> showNotification({
  required String title,
  required String body,
  int id = 0,
}) async {
  // Android notification details
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_channel', // Channel ID
    'Default Channel', // Channel name
    channelDescription: 'This is the default notification channel',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );

  // General notification details
  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
  );

  try {
    await flutterLocalNotificationsPlugin.show(
      id, // Notification ID (you can pass a unique ID for each notification)
      title, // Notification title
      body, // Notification body
      details,
    );
  } catch (e) {
    print("Error showing notification: $e");
  }
}
