import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_app/state_notifier_provider_todo/todo_model.dart';

final todolistProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
  (ref) => TodoListNotifier(
    List.generate(
      10,
      (i) => Todo(id: i, title: 'Task #$i', completed: i % 3 == 0),
    ),
  ),
);

final todoListLengthProvider = Provider<int>((ref) {
  return ref.watch(todolistProvider).length;
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier(super.state);

  void add(String title) {
    final newTodo = Todo(
      id: state.isEmpty ? 0 : state.last.id + 1,
      title: title,
      completed: false,
    );
    state = [...state, newTodo];
  }

  void remove(int id) {
    state = state.where((t) => t.id != id).toList();
  }

  void toggle(int id) {
    final todos = [...state];

    final index = todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final todo = todos[index];
    todos[index] = todo.copyWith(completed: !todo.completed);
    state = todos;
  }
}
