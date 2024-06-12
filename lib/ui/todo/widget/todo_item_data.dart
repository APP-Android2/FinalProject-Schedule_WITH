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
