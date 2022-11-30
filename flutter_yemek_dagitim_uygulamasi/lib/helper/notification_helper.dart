/* import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize =  IOSInitializationSettings();
    var InitializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(InitializationsSettings,onSelectNotification:(String? payload));
  try {
    if (payload!=null&&payload.isNotEmpty) {
      
    }
  } catch (e) {
    
  }
  }
} */


