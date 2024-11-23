import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServiceDataSource {
  final http.Client client;

  AuthServiceDataSource(this.client);

  Future<void> loginUser({
    required String phone,
    required String password,
  }) async {
    const url = 'https://go-auth.srv/api/auth/login';
    final Map<String, dynamic> body = {
      "phone": phone,
      "password": password,
    };

    print(body);

    final response = await client.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      print('Data fetched successfully: $data');
    } else {
      print(response.body);
      throw Exception('LoginService() loginUser() statusCode ${response.statusCode}');
    }
  }

  Future<void> registerUser({
    required String first_name,
    required String last_name,
    required String middle_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    const url = 'https://go-auth.srv/api/auth/register';

    final Map<String, dynamic> body = {
      "first_name": first_name,
      "last_name": last_name,
      "middle_name": last_name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirm": password_confirm,
    };

    print(body);

    final response = await client.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      print('Data fetched successfully: $data');
    } else {
      print(response.body);
      throw Exception('RegisterService() registerUser() ${response.statusCode}');
    }
  }
}
