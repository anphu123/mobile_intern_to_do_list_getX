class TodoModel {
  final String id;
  final String title;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone ? 1 : 0, // SQLite không có kiểu boolean, dùng 0 và 1
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      isDone: (map['isDone'] as int) == 1,
    );
  }
}