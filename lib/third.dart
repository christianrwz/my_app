import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final textProvider = StateProvider.autoDispose<String>((Ref ref) {
  return '';
});

class StatefulConsumer extends ConsumerStatefulWidget {
  const StatefulConsumer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StatefulConsumerState();
}

class _StatefulConsumerState extends ConsumerState<StatefulConsumer> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Init controller and listen for changes
    _controller = TextEditingController();
    _controller.addListener(() {
      ref.read(textProvider.notifier).state = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(textProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Text Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: _controller),
            SizedBox(height: 20),
            Text('You typed: $text'),
          ],
        ),
      ),
    );
  }
}
