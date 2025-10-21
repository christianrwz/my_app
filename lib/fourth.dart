import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/fake_api_service.dart';

/// Create a FakeService Instance
final fakeApiProvider = Provider((_) => FakeService());

/// Create a Future Provider
final greetingFutureProvider = FutureProvider((Ref ref) async {
  final service = ref.read(fakeApiProvider);
  return await service.fetchGreeting();
});

/// UI Screen to display Future data
class GreetingScreen extends ConsumerWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the FutureProvider
    final greetingAsync = ref.watch(greetingFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Async Greeting')),
      body: Center(
        /// Load data
        child: greetingAsync.when(
          skipLoadingOnRefresh: false,
          loading: () => CircularProgressIndicator(),
          error: (error, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(greetingFutureProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
          data: (greeting) => Text(greeting, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
