import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/fourth.dart';

final greetingAsyncProvider = AsyncNotifierProvider<GreetingAsyncNotifier, String>(
    () => GreetingAsyncNotifier());

class GreetingAsyncNotifier extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    return ref.read(fakeApiProvider).fetchGreeting();
  }

  Future<void> refreshGreeting() async {
    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async => await ref.read(fakeApiProvider).fetchGreeting());

    try {
      state = const AsyncValue.loading();
      final greeting = await ref.read(fakeApiProvider).fetchGreeting();
      state = AsyncValue.data(greeting);
    } catch (e, _) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
