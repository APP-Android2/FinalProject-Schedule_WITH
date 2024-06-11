import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_with/entity/todo_tbl.dart';

class TodoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Todo>> getTodos() {
    return _db.collection('todo')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Todo.fromFirestore(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<void> updateTodoStatus(int idx, bool isCompleted) {
    return _db.collection('todo')
        .where('idx', isEqualTo: idx)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({'todo_status': isCompleted ? 'Y' : 'N'});
      }
    });
  }
}
