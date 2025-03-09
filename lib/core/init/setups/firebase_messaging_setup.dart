// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:process/firebase_options.dart';
//
// class FirebaseMessagingSetup {
//   static Future<void> call() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     String? token = await messaging.getToken();
//
//     // logger.i(token);
//
//     /// Sending FCM token to server
//     // if (token != null) {
//     //   await sendDeviceTokenToServer(token);
//     // }
//   }
// }