import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:process/core/dependency/dotenv_init.dart';
import 'package:process/core/dependency/form_validator_init.dart';
import 'package:process/core/dependency/http_override_init.dart';
import 'package:process/core/dependency/uisystem_init.dart';
import 'package:process/firebase_options.dart';
import 'package:process/core/dependency/local_notification_init.dart';
import 'package:process/core/dependency/firebase_messaging_init.dart';


class AppInit {
  // static AppRepo repo = AppRepo();

  static Future<void> initialize() async {

    /// Flutter Widgets initialization
    WidgetsFlutterBinding.ensureInitialized();

    /// Http overrides initialization
    HttpOverridesInit.setup();

    /// Validator form initialization (uses the "form_validator" package)
    FormValidatorInit.setup();

    /// UISystemInit initialization
    UISystemInit.setup();

    /// Read .env file and load variables (uses the "flutter_dotenv" package)
    await DotEnvInit.setup();

    /// Firebase initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// Firebase Messaging initialization (uses the "firebase_messaging" package)
    // await FirebaseMessagingInit.setup();

    /// Local Notifications initialization (uses the "flutter_local_notifications" package)
    // await LocalNotificationInit.setup();

    /// Easy Localization initialization (uses the "easy_localization" package)
    await EasyLocalization.ensureInitialized();

    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // FirebaseAnalytics.instance;

    /// GetUser data and save it
    // await UserDataInit.setup();
  }

}
