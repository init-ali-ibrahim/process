// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserDataInit {
//   static final Dio dio = Dio();
//   static final SecureStorageService storage = SecureStorageService();
//
//   static Future<void> setup() async {
//     try {
//
//       final user = await getUser();
//       final chatUser = await getChatUser();
//
//       final updatedUser = UserModel(
//         userId: user.userId,
//         userChatId: chatUser?['id'] ?? 0,
//         firstName: user.firstName,
//         middleName: user.middleName,
//         lastName: user.lastName,
//         phoneNumber: user.phoneNumber,
//         email: user.email,
//         pictureUrl: user.pictureUrl,
//       );
//
//       await saveUserData(updatedUser);
//     } catch (e) {
//       logger.e('e: $e');
//     }
//   }
//
//   static Future<UserModel> getUser() async {
//     final String baseUrl = '$urlAuthFromEnv/auth/user';
//     String? accessToken = await storage.getAccessToken();
//
//     final Map<String, dynamic> headers = {
//       "X-ACCESS-TOKEN": accessToken,
//       "X-API-KEY": apiKey,
//       "Content-Type": "application/json",
//     };
//
//     try {
//       final response = await dio.get(
//         baseUrl,
//         options: Options(headers: headers),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = response.data['data'] as Map<String, dynamic>;
//         UserModel user = UserModel.fromJson(data);
//         return user;
//       } else {
//         throw Exception('Error: ${response.data}');
//       }
//     } on DioException catch (e) {
//       throw Exception('DioException: ${e.response}');
//     }
//   }
//
//   static Future<Map<String, dynamic>?> getChatUser() async {
//     final String baseUrl = '$urlChatFromEnv/auth/user';
//     String? accessToken = await storage.getAccessToken();
//
//     final headers = {
//       'x-access-token': accessToken,
//       'Content-Type': 'application/json',
//     };
//
//     try {
//       final response = await dio.get(
//         baseUrl,
//         options: Options(headers: headers),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = response.data as Map<String, dynamic>;
//         return data as Map<String, dynamic>?;
//       } else {
//         throw Exception('Error: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       throw Exception('Request failed: $e');
//     }
//   }
//
//   static Future<void> saveUserData(UserModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//
//     prefs.setString('userData', jsonEncode(user.toJson()));
//   }
//
// Future<UserModel?> loadUserData() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   String? userDataString = prefs.getString('userData');
//
//   if (userDataString != null) {
//     Map<String, dynamic> userData =
//     jsonDecode(userDataString);
//     return UserModel.fromJson(userData);
//   }
//
//   logger.i('No user data found');
//   return null;
// }
// }
