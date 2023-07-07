import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_test_project/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getListTodoFromCache();
  Future<void> todoToCache(List<Todo> todo);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  TodoLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> todoToCache(List<Todo> todos) {
    final List<String> jsonTodo =
        todos.map((todo) => json.encode(todo.toJson())).toList();

    sharedPreferences.setStringList('CachedTodo', jsonTodo);
    log('записано в кэш');
    return Future.value(jsonTodo);
  }

  @override
  Future<List<Todo>> getListTodoFromCache() {
    final jsonTodoList = sharedPreferences.getStringList('CachedTodo');
    if (jsonTodoList == null) {
      throw Exception();
    } else if (jsonTodoList.isNotEmpty) {
      return Future.value(
        jsonTodoList
            .map(
              (todo) => Todo.fromJson(
                json.decode(todo),
              ),
            )
            .toList(),
      );
    } else {
      throw Exception();
    }
  }
}
