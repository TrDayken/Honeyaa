import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract class PushNotification {
  void initialize(String apiKey);
  Stream<OSNotification> get onNotification;
  void dispose();
}
