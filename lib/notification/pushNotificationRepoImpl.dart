import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:honeyaa_clientside/notification/pushNotificationRepo.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationRepoImpl implements PushNotification {
  final OneSignal _oneSignal;

  PushNotificationRepoImpl(this._oneSignal);

  @override
  void initialize(String apiKey) {
    if (kDebugMode) {
      _oneSignal.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }

    _oneSignal.setAppId(apiKey);
    _oneSignal.promptUserForPushNotificationPermission();

    _oneSignal.setNotificationWillShowInForegroundHandler((event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      final notification = event.notification;
      event.complete(event.notification);
      print(notification.title);
      print(notification.body);
    });

    _oneSignal
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
      final notification = result.notification;

      print(notification.title);
      print(notification.body);
    });
  }
}
