import 'dart:io';

class DeviceUtil {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;

  static String get platformName {
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    return 'Unknown';
  }
}
