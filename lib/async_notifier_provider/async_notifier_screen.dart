import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/async_notifier_provider/async_notifier.dart';

class AsyncGreetingScreen extends ConsumerWidget {
  const AsyncGreetingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greetingAsync = ref.watch(greetingAsyncProvider);
    final greetingAsyncNotifier = ref.watch(greetingAsyncProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Async Notifier Demo')),
      body: Center(
        child: greetingAsync.when(
          skipLoadingOnRefresh: false,
          loading: () => CircularProgressIndicator(),
          error: (error, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error', style: TextStyle(color: Colors.red)),
            ],
          ),
          data: (greeting) => Text(greeting, style: TextStyle(fontSize: 24)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: greetingAsyncNotifier.refreshGreeting,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
