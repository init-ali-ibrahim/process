// import 'package:flutter/material.dart';
// import 'package:another_flushbar/flushbar.dart';
//
// class GlobalFlushbarManager {
//   static Flushbar? _currentFlushbar;
//
//   static void showFlushbar(BuildContext context, {
//     required String message,
//     String? title,
//     Duration duration = const Duration(seconds: 4),
//     bool persistent = false,
//   }) {
//     _currentFlushbar?.dismiss();
//
//     _currentFlushbar = Flushbar(
//       message: message,
//       title: title,
//       duration: persistent ? null : duration,
//       margin: const EdgeInsets.all(8),
//       borderRadius: BorderRadius.circular(12),
//       backgroundColor: Colors.black87,
//       boxShadows: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.2),
//           offset: const Offset(0, 2),
//           blurRadius: 8,
//         )
//       ],
//
//       forwardAnimationCurve: Curves.easeOutCubic,
//       reverseAnimationCurve: Curves.easeInCubic,
//
//       dismissDirection: FlushbarDismissDirection.HORIZONTAL,
//
//       onStatusChanged: (status) {
//         if (status == FlushbarStatus.IS_APPEARING) {
//         }
//       },
//
//       onTap: (_) {
//       },
//
//       mainButton: persistent ? TextButton(
//         onPressed: () {
//           _currentFlushbar?.dismiss();
//         },
//         child: const Text(
//           'ЗАКРЫТЬ',
//           style: TextStyle(color: Colors.white),
//         ),
//       ) : null,
//
//       routeBlur: 5.0,
//       routeColor: Colors.black.withOpacity(0.15),
//
//       isDismissible: true,
//       shouldIconPulse: true,
//       icon: const Icon(
//         Icons.info_outline,
//         color: Colors.white,
//       ),
//     )..show(context);
//   }
//
//   static void dismiss() {
//     _currentFlushbar?.dismiss();
//     _currentFlushbar = null;
//   }
// }
//
// // class App extends StatelessWidget {
// //   const App({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       builder: (context, child) {
// //         return Navigator(
// //           onGenerateRoute: (settings) {
// //             return MaterialPageRoute(
// //               builder: (context) => child!,
// //             );
// //           },
// //         );
// //       },
// //       home: const FlushbarExample(),
// //     );
// //   }
// // }