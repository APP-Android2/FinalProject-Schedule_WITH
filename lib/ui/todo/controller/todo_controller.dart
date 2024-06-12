import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repository/todo_repository.dart';
import 'package:schedule_with/entity/todo_tbl.dart';

class TodoController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var todoItems = <Todo>[].obs;
  var todoIdx = 0.obs;

  final TodoRepository todoRepository = TodoRepository();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_idx = prefs.getInt('idx');
      if (user_idx != null) {
        List<Todos> todosFromDb = await todoRepository.getAllTodos(user_idx);
        print("List: ${todosFromDb.toList()}");
        todoItems.addAll(todosFromDb.map((todo) => Todo(
          idx: todo.idx,
          title: todo.title,
          date: todo.todo_dt,
          check: todo.check,
        )));
      } else {
        print("User index not found in SharedPreferences.");
      }
    } catch (e) {
      print("Error fetching todos: $e");
    }
  }

  void addTodoItem(int idx, String title, String description, DateTime date) {
    todoItems.add(Todo(
      idx: idx,
      title: title,
      date: date,
      check: false,
    ));
  }

  void removeTodoItem(int idx) async {
    Todo? todoToRemove = todoItems.firstWhere((todo) => todo.idx == idx);
    if (todoToRemove != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_idx = prefs.getInt('idx');
      if (user_idx != null) {
        // 업데이트할 새로운 데이터
        Map<String, dynamic> newData = {
          'status': 'N'
        };
        // updateTodo 메서드 호출
        await todoRepository.updateTodo(user_idx, idx, newData);
        // 리스트에서 아이템 제거
        todoItems.remove(todoToRemove);
      }
    }
  }

  void updateTodoItem({required int idx, required String oldTitle, required String newTitle, required DateTime newDate}) {
    Todo? todoToUpdate = todoItems.firstWhere((todo) => todo.idx == idx);

    if (todoToUpdate != null) {
      todoItems.remove(todoToUpdate);
      todoItems.add(Todo(
        idx: idx,
        title: newTitle,
        check: todoToUpdate.check.value,
        date: newDate,
      ));
    }
  }

  void toggleTodoCheck(Todo todo) async {
    todo.check.value = !todo.check.value;
    await todoRepository.updateTodoCheck(todo.idx, todo.check.value);
  }

  List<Todo> getTodosForDate(DateTime date) {
    return todoItems.where((todo) =>
    todo.date.year == date.year &&
        todo.date.month == date.month &&
        todo.date.day == date.day).toList();
  }

  void updateDt(DateTime newDate) {
    selectedDate.value = newDate;
  }
}

class Todo {
  final int idx;
  final String title;
  final DateTime date;
  final RxBool check;

  Todo({
    required this.idx,
    required this.title,
    required this.date,
    required bool check,
  }) : check = check.obs;
}
