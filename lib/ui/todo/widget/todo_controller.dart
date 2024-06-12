import 'package:get/get.dart';
import 'package:schedule_with/ui/todo/widget/todo_item_data.dart';

class TodoController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var todoList = <TodoItemData>[].obs;

  void addTodoItem(String date, String content) {
    final newItem = TodoItemData(date: date, content: content);
    todoList.add(newItem);
    print('Todo item added: $date - $content');
  }

  void updateTodoItem(String oldDate, TodoItemData updatedItem) {
    int index = todoList.indexWhere((item) => item.date == oldDate && item.content == updatedItem.content);
    if (index != -1) {
      todoList[index] = updatedItem;
    } else {
      todoList.removeWhere((item) => item.date == oldDate && item.content == updatedItem.content);
      addTodoItem(updatedItem.date, updatedItem.content);
    }
    print('Todo item updated: ${updatedItem.date} - ${updatedItem.content}');
  }

  void deleteTodoItem(String date, TodoItemData itemToDelete) {
    todoList.removeWhere((item) => item.date == date && item.content == itemToDelete.content);
    print('Todo item deleted: $date - ${itemToDelete.content}');
  }

  List<TodoItemData> getTodoItemsForDate(String date) {
    return todoList.where((item) => item.date == date).toList();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    print('Selected date updated: $date');
  }

  double calculateCompletionRate(String date) {
    final todosForDate = getTodoItemsForDate(date);
    if (todosForDate.isEmpty) return 0.0;
    final completedCount = todosForDate.where((item) => item.isCompleted).length;
    return completedCount / todosForDate.length;
  }
}
