import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Text field + submit button used at the top of [HomePage] to add a task.
class AddTodoField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmit;

  const AddTodoField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  void _submit() {
    onSubmit(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'add_task_hint'.tr,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _submit,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
