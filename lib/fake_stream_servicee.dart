import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerServiceProvider = Provider((_) => TimeService());

class TimeService {
  // Emits an integer every second, starting at 0
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (count) => count);
  }

  // In TimerService
  Stream<int> tickWithError() async* {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
    throw Exception('Timer stopped unexpectedly!');
  }
}
