import 'package:get/get.dart';

class TodoItemData {
  String date;
  String content;
  bool isCompleted;

  TodoItemData({
    required this.date,
    required this.content,
    this.isCompleted = false,
  });
}

class TodoController extends GetxController {
  var todoItemsByDate = <String, List<TodoItemData>>{}.obs;

  void addTodoItem(String date, String content) {
    if (todoItemsByDate[date] == null) {
      todoItemsByDate[date] = <TodoItemData>[].obs;
    }
    todoItemsByDate[date]!.add(TodoItemData(date: date, content: content));
  }

  void updateTodoItem(String date, TodoItemData updatedTodoItem) {
    int index = todoItemsByDate[date]!.indexWhere((item) => item.content == updatedTodoItem.content);
    if (index != -1) {
      todoItemsByDate[date]![index] = updatedTodoItem;
      todoItemsByDate.refresh();
    }
  }

  void deleteTodoItem(String date, TodoItemData todoItemData) {
    todoItemsByDate[date]!.remove(todoItemData);
    todoItemsByDate.refresh();
  }

  List<TodoItemData> getTodoItemsForDate(String date) {
    return todoItemsByDate[date] ?? [];
  }

  double calculateCompletionRate(String date) {
    List<TodoItemData> todosForSelectedDate = todoItemsByDate[date] ?? [];
    if (todosForSelectedDate.isEmpty) {
      return 0.0;
    }
    int completedCount = todosForSelectedDate.where((item) => item.isCompleted).length;
    return completedCount / todosForSelectedDate.length;
  }
}
