import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmManager {
  static void requestPermission() {
    FirebaseMessaging.instance.requestPermission();
  }

  static void initialize() async {
    /// ForeGround
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground 상태 에서 메세지 수신 됨');
      debugPrint('Message data는 ${message.data} 입니다.');

      if (message.notification != null) {
        final title = message.notification?.title;
        final text = message.notification?.body;
        debugPrint('Message notification는 ${message.notification} 입니다.');
        debugPrint('Message title은 $title 입니다.');
        debugPrint('Message text는 $text 입니다.');
      }
    });

    /// BackGround
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('Background 상태 에서 메세지 수신 됨');
      debugPrint('Message data는 ${message.data} 입니다.');
    });
  }
}
