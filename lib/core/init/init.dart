import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:process/core/init/setups.dart';
import 'package:process/firebase_options.dart';

class AppInit {
  static Future<void> initialize() async {

    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    HttpOverridesSetup();
    SystemUiSetup();
    DotEnvSetup();

    FormValidatorInit.setup();

    /// Firebase initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
