import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final staticProvider = Provider<String>((Ref ref) {
  return 'Hello World';
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(staticProvider);

    return Scaffold(body: Center(child: Text(result)));
  }
}
