import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_app/computed_provider/computer_provider.dart';
import 'package:my_app/state_notifier_provider_todo/todo_model.dart';
import 'package:my_app/state_notifier_provider_todo/todo_provider_controller.dart';

final simpleSelectProvider = StateProvider(
  (ref) => Todo(id: 1, title: 'Create Riverpod Crash Course', completed: true),
);

class SelectSimpleDemo extends ConsumerWidget {
  const SelectSimpleDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(
      simpleSelectProvider.select((item) => item.completed),
    );
    final title = ref.read(simpleSelectProvider).title;
    print('Rebuild');
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'WITH select',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text('Title (read): $title'),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Completed: '),
              Checkbox(
                value: completed,
                onChanged: (_) {
                  final t = ref.read(simpleSelectProvider);
                  ref.read(simpleSelectProvider.notifier).state = t.copyWith(
                    completed: !t.completed,
                  );
                },
              ),
              Checkbox(
                value: completed,
                onChanged: (_) {
                  final t = ref.read(simpleSelectProvider);
                  ref.read(simpleSelectProvider.notifier).state = t.copyWith(
                    title: 'Sample',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
