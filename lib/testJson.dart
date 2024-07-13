import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/test_json_bloc.dart';

class testJson extends StatefulWidget {
  const testJson({super.key});

  @override
  State<testJson> createState() => _testJsonState();
}

class _testJsonState extends State<testJson> {

  final String jsonString = '''
  [
    {"name": "John", "age": 30},
    {"name": "Jane", "age": 25},
    {"name": "Doe", "age": 35}
  ]
  ''';

  @override
  Widget build(BuildContext context) {

    final dataJson = jsonDecode(jsonString);

    return BlocBuilder<TestJsonBloc, TestJsonState>(
      builder: (context, state) {
        if (state is TestJsonInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   'Счет: ${state.text}',
                //   style: TextStyle(fontSize: 24),
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<TestJsonBloc>().add(testTestEvent('Новый текст'));
                  },
                  child: Text('Изменить текст'),
                ),
                SizedBox(height: 20),
                Text(
                  'Текст: ${state.text}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('Неизвестное состояние'),
          );
        }
      },
    );
  }
}
