import 'package:get/get.dart';
import 'package:schedule_with/entity/todo_tbl.dart';
import '../../../domain/use_case/todo_use_case.dart';

class HomeTodoController extends GetxController {
  final TodoUseCase todoUseCase;
  var todos = <Todo>[].obs;

  HomeTodoController({required this.todoUseCase});

  @override
  void onInit() {
    super.onInit();
    todoUseCase.getTodos().listen((data) {
      print('Firestore data: $data'); // Firestore에서 가져온 데이터를 출력하여 확인
      todos.value = data;
    });
  }

  void toggleTodoStatus(int idx, bool isCompleted) {
    todoUseCase.updateTodoStatus(idx, isCompleted);
  }
}
