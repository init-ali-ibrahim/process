import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIKnkB2ZrzjOcH_vVj5Bt1rCLfGjmSbiI',
    appId: '1:505310485441:android:e7f017932538d6759b2d40',
    messagingSenderId: '505310485441',
    projectId: 'pushnotification-744c7',
    databaseURL: 'https://pushnotification-744c7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'pushnotification-744c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAVzlB10xxiDG1nFJESK7RreH9Rp4rR7I',
    appId: '1:505310485441:ios:de92658e8f4b0fa39b2d40',
    messagingSenderId: '505310485441',
    projectId: 'pushnotification-744c7',
    databaseURL: 'https://pushnotification-744c7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'pushnotification-744c7.appspot.com',
    iosBundleId: 'y',
  );
}
