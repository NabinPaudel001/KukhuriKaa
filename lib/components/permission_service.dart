// -------------------------------------------------
// FUNCTION FOR REQUESTING NOTIFICATION PERMISSIONS
// -------------------------------------------------
import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  // Check if permission is granted on Android 13 and later
  if (await Permission.notification.isGranted) {
    return; // Permission is already granted
  } else if (await Permission.notification.request().isGranted) {
    return; // Permission is granted after request
  } else {
    // Handle case where permission is not granted
    print('Notification permission is denied');
  }
}
