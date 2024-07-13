import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_json_event.dart';
part 'test_json_state.dart';

class TestJsonBloc extends Bloc<TestJsonEvent, TestJsonState> {
  TestJsonBloc() : super(TestJsonInitial("")) {
    on<testTestEvent>((event, emit) {

    });
  }
}
