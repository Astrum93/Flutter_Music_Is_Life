import 'package:firebase_messaging/firebase_messaging.dart';

class FcmManager {
  static void requestPermission() {
    FirebaseMessaging.instance.requestPermission();
  }

  /// BackGround
}
