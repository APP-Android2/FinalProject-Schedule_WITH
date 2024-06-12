import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_with/entity/todo_tbl.dart';

class TodoRepository {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  // TodoSequence 값을 가져온다.
  Future<int?> getTodoSequence() async {
    DocumentReference documentRef = _firebase.collection('Sequence').doc(
        'TodoSequence');
    DocumentSnapshot doc = await documentRef.get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data['value'];
    } else {
      return null;
    }
  }

  // TodoSequence 값을 업데이트 한다.
  Future<void> updateTodoSequence(int todoSequence) async {
    await _firebase.collection('Sequence').doc('TodoSequence').update({
      'value': todoSequence,
    });
  }

  // 투부 정보를 firebase에 저장하는 메서드
  Future<void> saveTodoInfo(Todos todo) async {
    await _firebase.collection("todo").add({
      'idx': todo.idx,
      'user_idx': todo.user_idx,
      'group_idx': todo.group_idx,
      'todo_dt': todo.todo_dt,
      'title': todo.title,
      'status': todo.status,
      'reg_dt': todo.reg_dt,
      'mod_dt': todo.mod_dt,
      'check': todo.check,
    });
  }

  // 유저번호와 status가 Y인것만 맞게 todo컬렉션을 모두 가져온다.
  Future<List<Todos>> getAllTodos(int user_idx) async {
    QuerySnapshot querySnapshot = await _firebase
        .collection("todo")
        .where('user_idx', isEqualTo: user_idx)
        .where('status', isEqualTo: 'Y')
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Todos(
        idx: data['idx'],
        user_idx: data['user_idx'],
        group_idx: data['group_idx'],
        todo_dt: data['todo_dt'].toDate(),
        title: data['title'],
        status: data['status'],
        reg_dt: data['reg_dt'].toDate(),
        mod_dt: data['mod_dt'].toDate(),
        check: data['check'],
      );
    }).toList();
  }

  // 체크 상태에 따라 firebase에 업데이트 해준다.
  Future<void> updateTodoCheck(int idx, bool check) async {
    // Find the document by idx and update the check field
    QuerySnapshot querySnapshot = await _firebase.collection("todo").where(
        'idx', isEqualTo: idx).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      await docRef.update({'check': check});
    }
  }

  // 유저 번호와 idx번호에 맞게 todo문서를 업데이트 해준다.
  Future<void> updateTodo(int user_idx, int todo_idx, Map<String, dynamic> newData) async {
    // 해당 사용자 및 할 일 문서에 대한 참조 가져오기
    QuerySnapshot querySnapshot = await _firebase.collection("todo")
        .where('user_idx', isEqualTo: user_idx)
        .where('idx', isEqualTo: todo_idx)
        .get();

    // 필터링된 문서가 존재하는지 확인
    if (querySnapshot.docs.isNotEmpty) {
      // 첫 번째 문서 가져오기 (여기서는 해당 조건에 맞는 문서가 하나뿐이므로 첫 번째 문서를 가져옵니다)
      DocumentSnapshot doc = querySnapshot.docs.first;

      // 문서 참조
      DocumentReference docRef = doc.reference;

      // 새 데이터로 문서 업데이트
      await docRef.update(newData);
    }
  }
}
