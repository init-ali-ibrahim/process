import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:process/firebase_options.dart';

class FirebaseMessagingInit {
  static Future<void> setup() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();

    // logger.i(token);

    /// Sending FCM token to server
    // if (token != null) {
    //   await sendDeviceTokenToServer(token);
    // }
  }
}