import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:honeyaa_clientside/notification/pushNotificationRepo.dart';
import 'package:honeyaa_clientside/notification/pushNotificationRepoImpl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void injectionDependencies() {
  Get.i.lazyPut<PushNotification>(
      () => PushNotificationRepoImpl(OneSignal.shared));
}
