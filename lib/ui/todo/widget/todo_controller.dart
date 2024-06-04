import 'package:get/get.dart';

class TodoController extends GetxController {
  var todoItems = <TodoItemData>[].obs;

  List<TodoItemData> getTodoItemsForDate(String date) {
    return todoItems.where((item) => item.date == date).toList();
  }

  void addTodoItem(String date, String content) {
    todoItems.add(TodoItemData(date: date, content: content, isCompleted: false));
  }

  void updateTodoItem(String date, TodoItemData updatedItem) {
    int index = todoItems.indexWhere((item) => item.date == date && item.content == updatedItem.content);
    if (index != -1) {
      todoItems[index] = updatedItem;
    }
  }

  void deleteTodoItem(String date, TodoItemData itemToDelete) {
    todoItems.removeWhere((item) => item.date == date && item.content == itemToDelete.content);
  }

  double calculateCompletionRate(String date) {
    List<TodoItemData> itemsForDate = getTodoItemsForDate(date);
    if (itemsForDate.isEmpty) {
      return 0.0;
    }
    int completedCount = itemsForDate.where((item) => item.isCompleted).length;
    return completedCount / itemsForDate.length;
  }
}

class TodoItemData {
  final String date;
  String content;
  bool isCompleted;

  TodoItemData({
    required this.date,
    required this.content,
    this.isCompleted = false,
  });
}
