import 'package:flutter/material.dart';
import 'package:integration_test_workshop/src/todo/todo_model.dart';

class TodoController extends ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodoStatus(int index, bool status) {
    _todos[index].isDone = status;
    notifyListeners();
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
