import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_project/popup.dart';
import 'package:riverpod_test_project/todo.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todo = ref.watch(filteredListProvider);

    if (todo.isNotEmpty) {
      return Column(
        children: [
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: todo.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => ref
                      .read(todoProvider.notifier)
                      .removeTodo(todo[index].id),
                  child: CheckboxListTile(
                    value: todo[index].isCompleted,
                    onChanged: (value) => ref
                        .read(todoProvider.notifier)
                        .toggleStatus(todo[index].id),
                    title: Text(todo[index].description),
                  ),
                );
              },
            ),
          ),
          FilledButton(
              onPressed: () => ref.read(todoProvider.notifier).addTodo(
                    Todo(
                      id: DateTime.now().toString(),
                      description: 'first todo',
                      isCompleted: false,
                    ),
                  ),
              child: const Text('tap'))
        ],
      );
    } else {
      return const Center(child: PopupWidget()
          // AddButton(
          //   add:
          // () => ref.read(todoProvider.notifier).addTodo(
          //       Todo(
          //         id: DateTime.now().toString(),
          //         description: 'first todo',
          //         isCompleted: false,
          //       ),
          //     ),
          );
    }
  }
}
