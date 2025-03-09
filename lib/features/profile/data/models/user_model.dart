
import 'package:process/core/global/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    email: email,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      firstName: json['name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone'] as String,
      email: json['email'] as String,
    );
  }
}
