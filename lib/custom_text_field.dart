import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_project/todo.dart';

class CustomTextField extends ConsumerWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController messageController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
          ),
        ),
        IconButton(
            onPressed: () {
              ref.read(todoProvider.notifier).addTodo(
                    Todo(
                      id: DateTime.now().toString(),
                      description: messageController.text.trim().toString(),
                      isCompleted: false,
                    ),
                  );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
