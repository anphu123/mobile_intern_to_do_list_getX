import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/app_empty_state.dart';
import 'home_controller.dart';
import 'widgets/add_todo_field.dart';
import 'widgets/todo_list_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app_title'.tr)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: AddTodoField(
              controller: TextEditingController(),
              onSubmit: controller.addTodo,
            ),
          ),
          Expanded(
            child: Obx(() {
              final todos = controller.todos;
              if (todos.isEmpty) {
                return AppEmptyState(message: 'no_tasks'.tr);
              }
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoListItem(
                    todo: todo,
                    onToggle: (_) => controller.toggleTodo(todo.id),
                    onDelete: () => controller.removeTodo(todo.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
