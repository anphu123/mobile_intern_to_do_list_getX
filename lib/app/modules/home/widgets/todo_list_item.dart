import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../data/model/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: todo.isDone, onChanged: onToggle),
      title: Text(
        todo.title,
        style: todo.isDone ? AppTextStyles.done : AppTextStyles.body,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
