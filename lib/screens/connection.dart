// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class ConnectivityChecker extends StatefulWidget {
//   final Widget child;
//
//   ConnectivityChecker({required this.child});
//
//   @override
//   _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
// }
//
// class _ConnectivityCheckerState extends State<ConnectivityChecker> {
//   late Connectivity _connectivity;
//   late Stream<ConnectivityResult> _connectivityStream;
//   ConnectivityResult _lastResult = ConnectivityResult.mobile;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectivity = Connectivity();
//     // _connectivityStream = _connectivity.onConnectivityChanged;
//
//     _connectivityStream.listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.none) {
//         _showSnackBar('Проверте подключение к сети!');
//       } else if (_lastResult == ConnectivityResult.none && result != ConnectivityResult.none) {
//         // _showSnackBar('Connected to the internet');
//       }
//
//       _lastResult = result;
//     });
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(width: 10),
//             Icon(Icons.wifi_rounded, color: Colors.red.shade300, size: 20),
//             const SizedBox(width: 10),
//             const Text(
//               'Проверте подключение к сети!',
//               style: TextStyle(color: Colors.black),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         duration: const Duration(seconds: 5),
//         action: SnackBarAction(
//           label: 'ок',
//           textColor: Colors.red.shade300,
//           onPressed: () {
//             // Пользовательское действие
//           },
//         ),
//         elevation: 0.2,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Возвращаем основной экран приложения
//     return widget.child;
//   }
// }
