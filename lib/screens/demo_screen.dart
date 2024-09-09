import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {


  final storage = FlutterSecureStorage();

  Future<void> sendOrder() async {
    const url = 'http://192.168.1.109/api/v1/app/orders';

    String? tokenAuth = await storage.read(key: 'token');

    if (tokenAuth == null) {
      print('No token found!');
      return;
    }

    File imgFile = File('/data/user/0/com.example.process/cache/0dfe3811-7dc8-476c-8cee-c7305b539f59/20240906_195853.jpg');

    try {
      // Проверка существования файла
      if (!await imgFile.exists()) {
        print('Image file does not exist at the given path.');
        return;
      }

      // Определение MIME-типа файла
      var mimeType = lookupMimeType(imgFile.path);
      if (mimeType == null) {
        print('Could not determine the MIME type of the file.');
        return;
      }

      // Создание запроса
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll({
          'Authorization': 'Bearer $tokenAuth', // Добавление токена в заголовок
          'City': 'almaty', // Пример дополнительного заголовка
        });

      try {
        // Добавление полей
        request.fields['name'] = 'дальат';
        request.fields['phone'] = '77066223709';
        request.fields['delivery_type'] = 'delivery';
        request.fields['address'] = 'asdas';
        request.fields['products[0][type]'] = 'costume';
        request.fields['products[0][costume_products][color]'] = 'blue';
        request.fields['products[0][costume_products][shape]'] = 'square';
        request.fields['products[0][costume_products][flavor]'] = 'black_cake';
        request.fields['products[0][costume_products][comments]'] = 'dsadsadsa';
        request.fields['products[0][quantity]'] = '10';
        request.fields['products[0][price]'] = '10';

        // Добавление файла
        var mimeParts = mimeType.split('/');
        var file = await http.MultipartFile.fromPath(
          'products[0][costume_products][img]',
          imgFile.path,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        );
        request.files.add(file);

        // Печать содержимого запроса
        print('Request URL: ${request.url}');
        print('Request Headers: ${request.headers}');
        print('Request Fields: ${request.fields}');
        for (var file in request.files) {
          print('Request File: ${file.filename}');
        }

        // Попытка отправить запрос
        try {
          var response = await request.send();

          // Чтение тела ответа
          var responseBody = await response.stream.bytesToString();
          print('Response status code: ${response.statusCode}');
          print('Response body: $responseBody');

          if (response.statusCode == 200 || response.statusCode == 201) {
            print('Order sent successfully');
          } else {
            print('Failed to send order. Status code: ${response.statusCode}');
          }
        } catch (e) {
          print('Error while sending the request: $e');
        }
      } catch (e) {
        print('Error while building the request: $e');
      }
    } catch (e) {
      print('Error handling the file: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Order'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendOrder,
          child: Text('Send Order'),
        ),
      ),
    );
  }
}
