import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/state_notifier_provider_todo/todo_model.dart';
import 'package:my_app/state_notifier_provider_todo/todo_provider_controller.dart';

class CompareSelectScreen extends ConsumerWidget {
  const CompareSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todolistProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Compare Select Demo')),
      body: Row(
        children: [
          // left
          // Expanded(
          //   child: Column(
          //     children: [
          //       const Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Text('Wothout select [bad]'),
          //       ),
          //       Expanded(child: TodoListWithoutSelect()),
          //     ],
          //   ),
          // ),

          // VerticalDivider(),

          // right
          Expanded(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Wothout select [good]'),
                ),
                Expanded(child: TodoListWithSelect()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => notifier.add('New Task ${DateTime.now().second}'),
        label: const Text('Add Todo'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

///
class TodoListWithoutSelect extends ConsumerWidget {
  const TodoListWithoutSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todolistProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, i) {
          final todo = todos[i];
          return TodoItemWithoutSelect(todo: todo);
        },
      ),
    );
  }
}

class TodoItemWithoutSelect extends ConsumerWidget {
  final Todo todo;

  const TodoItemWithoutSelect({required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todolistProvider.notifier);

    print('WithoutSelect: build item ${todo.id}');
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_) => notifier.toggle(todo.id),
      ),
    );
  }
}

class TodoListWithSelect extends ConsumerWidget {
  const TodoListWithSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final length = ref.watch(todoListLengthProvider);

    print('TodoListWithSelect: parent rebuilt, length $length');

    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, i) {
        final title = ref.read(todolistProvider)[i].title;
        final id = ref.read(todolistProvider)[i].id;
        return TodoItemWithSelect(todoId: id, title: title);
      },
    );
  }
}

class TodoItemWithSelect extends ConsumerWidget {
  final int todoId;
  final String title;

  const TodoItemWithSelect({
    required this.todoId,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(
      todolistProvider.select((list) {
        final t = list.firstWhere((t) => t.id == todoId);
        return t.completed;
      }),
    );

    final notifier = ref.read(todolistProvider.notifier);

    print('WithSelect: build item $todoId - completed: $completed');

    return ListTile(
      title: Text(title),
      leading: Checkbox(
        value: completed,
        onChanged: (_) => notifier.toggle(todoId),
      ),
    );
  }
}
