import 'dart:io';

class HttpOverridesSetup {
  Future<void> call() async {
    HttpOverrides.global = HttpOverrideCustom();
  }
}

class HttpOverrideCustom extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
