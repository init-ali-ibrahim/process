// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:initMobi/features/profile/data/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// final userProvider = FutureProvider<UserModel>((ref) async {
//   final prefs = await SharedPreferences.getInstance();
//   String? userDataString = prefs.getString('userData');
//
//   if (userDataString != null) {
//     Map<String, dynamic> userData = jsonDecode(userDataString);
//     return UserModel.fromSharedPreferences(userData);
//   } else {
//     return UserModel(
//       firstName: 'User',
//       lastName: 'Name',
//       email: 'user@example.com',
//       userId: 0,
//       middleName: '',
//       phoneNumber: '+7 (123) 456-78-90',
//       pictureUrl: '',
//       userChatId: 0,
//     );
//   }
// });
