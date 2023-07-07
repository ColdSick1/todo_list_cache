import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String id;
  final String description;
  final bool isCompleted;
  Todo(
      {required this.id, required this.description, required this.isCompleted});

  Todo copyWith({String? id, String? description, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'isCompleted': isCompleted,
      };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggleStatus(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }
}

final todoProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

enum Filter {
  none,
  completed,
  uncompleted,
}

final filterProvider = StateProvider((ref) => Filter.none);

final filteredListProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(filterProvider);
  final todos = ref.watch(todoProvider);

  switch (filter) {
    case Filter.none:
      return todos;
    case Filter.completed:
      return todos.where((element) => element.isCompleted).toList();
    case Filter.uncompleted:
      return todos.where((element) => !element.isCompleted).toList();
  }
});
