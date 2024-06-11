import 'package:schedule_with/domain/repository/todo_repository.dart';
import 'package:schedule_with/entity/todo_tbl.dart';

class TodoUseCase {
  final TodoRepository repository;

  TodoUseCase(this.repository);

  Stream<List<Todo>> getTodos() {
    return repository.getTodos();
  }

  Future<void> updateTodoStatus(int idx, bool isCompleted) {
    return repository.updateTodoStatus(idx, isCompleted);
  }
}
