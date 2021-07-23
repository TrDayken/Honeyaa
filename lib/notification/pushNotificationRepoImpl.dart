import 'dart:async';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:honeyaa_clientside/notification/pushNotificationRepo.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationRepoImpl implements PushNotification {
  final OneSignal _oneSignal;

  PushNotificationRepoImpl(this._oneSignal);
  final _controller = StreamController<OSNotification>.broadcast();
  Stream<OSNotification> get onNotification => _controller.stream;


  createNotification() async{
     var notification = OSCreateNotification(
      playerIds: ["d0591ff0-3291-4768-b12c-154cd0bc94d9"],
      content: "this is a test from OneSignal's Flutter SDK",
      heading: "Test Notification",
      //iosAttachments: {"id1": imgUrlString},
      //bigPicture: imgUrlString,
      buttons: [
        OSActionButton(text: "test1", id: "id1"),
        OSActionButton(text: "test2", id: "id2")
      ]);
 
  var response = await OneSignal.shared.postNotification(notification);
  print(response.values);
  }

  @override
  void initialize(String apiKey) {
    // if (kDebugMode) {
    //   _oneSignal.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    // }

    _oneSignal.setAppId(apiKey);
    _oneSignal.promptUserForPushNotificationPermission();

    _oneSignal.setNotificationWillShowInForegroundHandler((event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      final notification = event.notification;
      event.complete(event.notification);
      print(notification.title);
      print(notification.body);
      if(_controller.hasListener){
        _controller.sink.add((notification));
      }
    });

    _oneSignal
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
      final notification = result.notification;

      print(notification.title);
      print(notification.body);
    });
  }

  void dispose(){
    _controller.close();
  }
}
