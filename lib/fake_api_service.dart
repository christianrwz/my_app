import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Create a FakeService Instance
final fakeApiProvider = Provider((_) => FakeService());

class FakeService {
  Future<String> fetchGreeting() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate a 30% chance of failure
    if (Random().nextInt(5) < 4) {
      throw Exception('Failed to fetch greeting');
    }
    return 'Hello from Async!';
  }
}
