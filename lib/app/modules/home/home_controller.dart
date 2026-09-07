import 'package:get/get.dart';

import '../../core/errors/error_handler.dart';
import '../../core/utils/validators.dart';
import '../../data/model/todo_model.dart';

class HomeController extends GetxController {
  final todos = <TodoModel>[].obs;

  void addTodo(String title) {
    try {
      final validTitle = Validators.todoTitle(title);
      todos.add(
        TodoModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: validTitle,
        ),
      );
    } catch (e) {
      ErrorHandler.handle(e);
    }
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
