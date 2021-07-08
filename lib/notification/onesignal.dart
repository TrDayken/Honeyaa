import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void oneSignalInitialize() {
  if (kDebugMode) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  }

  OneSignal.shared.setAppId("486d8ce2-ec8c-4a58-9408-2b9e05c191c0");
}
