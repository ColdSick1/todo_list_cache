import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_project/todo.dart';
import 'package:riverpod_test_project/todo_list.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        title: const Text('todo-list'),
        actions: [
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: Filter.none,
                child: Text('все задачи'),
              ),
              DropdownMenuItem(
                value: Filter.completed,
                child: Text(
                  'Выполненные',
                ),
              ),
              DropdownMenuItem(
                value: Filter.uncompleted,
                child: Text('Не выполненные'),
              ),
            ],
            onChanged: (value) =>
                ref.read(filterProvider.notifier).state = value!,
          )
        ],
      ),
      body: const TodoListView(),
    );
  }
}
