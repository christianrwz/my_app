import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_app/state_notifier_provider_todo/todo_model.dart';
import 'package:my_app/state_notifier_provider_todo/todo_provider_controller.dart';

final numberProvider = StateProvider<List<int>>((_) => [1, 2, 3, 4, 5]);

/// Derived State
final sumProvider = Provider<int>((Ref ref) {
  final list = ref.watch(numberProvider);
  return list.fold(0, (total, n) => total + n);
});


/// Example 2
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier([]);
});

final filterTextProvider = StateProvider.autoDispose<String>((_) => '');

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider);
  final filter = ref.watch(filterTextProvider);

  if(filter.isEmpty) return todos;

  return todos.where((t) => t.title.toLowerCase().contains(filter)).toList();
});
