// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   // Initialize the plugin
//   static Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher'); // Your app icon

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // Show notification
//   static Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'alert_channel_id', // You can create your own channel id
//       'Alerts', // Channel name
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await _flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       title, // Title
//       body, // Message
//       platformChannelSpecifics,
//     );
//   }
// }
