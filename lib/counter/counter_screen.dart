import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/counter/counter_provider_controller.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final ctrl = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('State Provider')),
      body: Center(
        child: Text('Count: $count', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: ctrl.decrement,
            heroTag: 'dec',
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: ctrl.increment,
            heroTag: 'inc',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: ctrl.reset,
            heroTag: 'res',
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
