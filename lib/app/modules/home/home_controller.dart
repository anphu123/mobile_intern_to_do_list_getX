import 'package:get/get.dart';

import '../../core/base/base_controller.dart';
import '../../core/utils/validators.dart';
import '../../data/model/todo_model.dart';

class HomeController extends BaseController {
  final todos = <TodoModel>[].obs;

  Future<void> addTodo(String title) => runSafely(() async {
        final validTitle = Validators.todoTitle(title);
        todos.add(
          TodoModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: validTitle,
          ),
        );
      });

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
