import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/fake_stream_servicee.dart';

final tickerProvider = StreamProvider((Ref ref) {
  final service = ref.read(timerServiceProvider);
  // return service.tick();
  return service.tickWithError();
});

class TimerSreen extends ConsumerWidget {
  const TimerSreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickAsync = ref.watch(tickerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Live Timer')),
      body: Center(
        child: tickAsync.when(
          skipLoadingOnRefresh: false,
          data: (count) => Text(
            'Seconds elapsed: $count',
            style: const TextStyle(fontSize: 24),
          ),
          error: (e, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error $e', style: TextStyle(color: Colors.red)),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(tickerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
