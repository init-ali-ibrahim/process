part of 'test_json_bloc.dart';

@immutable
sealed class TestJsonState {}

final class TestJsonInitial extends TestJsonState {
  final String text;

  TestJsonInitial(this.text);
}

final class testTestState extends TestJsonState {
  final String text;

  testTestState(this.text);
}

