part of 'test_json_bloc.dart';

@immutable
sealed class TestJsonEvent {}

class testTestEvent extends TestJsonEvent {
  final String newText;

  testTestEvent(this.newText);
}