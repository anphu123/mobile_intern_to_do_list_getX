import 'package:get/get.dart';

import '../../../data/models/todo_model.dart';

class HomeController extends GetxController {
  final todos = <TodoModel>[].obs;

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    todos.add(
      TodoModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
    );
  }

  void toggleTodo(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index == -1) return;
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void removeTodo(String id) {
    todos.removeWhere((todo) => todo.id == id);
  }
}
