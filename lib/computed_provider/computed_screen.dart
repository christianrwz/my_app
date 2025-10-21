import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/computed_provider/computer_provider.dart';

class SumScreen extends ConsumerWidget {
  const SumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sum = ref.watch(sumProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sum Calculator')),
      body: Center(child: Text('Total = $sum', style: TextStyle(fontSize: 24))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final list = ref.read(numberProvider.notifier).state;
          ref.read(numberProvider.notifier).state = [...list, list.length + 1];
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoFilterScreen extends ConsumerWidget {
  const TodoFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);
    final notifier = ref.read(todoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Filtered Todos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: (t) => ref.read(filterTextProvider.notifier).state = t,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, i) {
                final todo = todos[i];
                return ListTile(
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (_) => notifier.toggle(todo.id),
                  ),
                  title: Text(todo.title),
                  trailing: IconButton(
                    onPressed: () => notifier.remove(todo.id),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          final text = 'New Todo Item';
          notifier.add(text);
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
