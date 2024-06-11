import 'package:get/get.dart';

import '../view/todo_main_screen.dart';

class TodoController extends GetxController{
  var selectedDate = DateTime.now().obs;
  var todoItems = <Todo>[].obs;

  void addTodoItem(String title, String description, DateTime date) {
    todoItems.add(Todo(
      title: title,

      date: date,
      check: false,
    ));
  }

  // 투두 항목 업데이트 메서드
  void updateTodoItem({required String oldTitle, required String newTitle, required DateTime newDate}) {
    // 기존 투두 항목 찾기
    Todo? todoToUpdate = todoItems.firstWhere((todo) => todo.title == oldTitle);

    // 투두 항목이 존재하는 경우 업데이트 수행
    if (todoToUpdate != null) {
      // 기존 투두 항목 삭제
      todoItems.remove(todoToUpdate);
      // 새로운 투두 항목 추가
      todoItems.add(Todo(
        title: newTitle,
        check: todoToUpdate.check.value,
        date: newDate,
      ));
    }
  }

  void toggleTodoCheck(Todo todo) {
    todo.check.value = !todo.check.value;
  }

  List<Todo> getTodosForDate(DateTime date) {
    return todoItems.where((todo) =>
    todo.date.year == date.year &&
        todo.date.month == date.month &&
        todo.date.day == date.day).toList();
  }
  // 캘린더에서 날짜 선택 시 해당 날짜로 업데이트
  void updateDt(DateTime newDate){
    selectedDate.value = newDate;
  }
}

class Todo {
  final String title;
  final DateTime date;
  final RxBool check;

  Todo({
    required this.title,
    required this.date,
    required bool check,
  }) : check = check.obs;
}
