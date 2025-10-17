import 'dart:math';
import 'dart:async';

class FakeService {
  Future<String> fetchGreeting() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate a 50% chance of failure

    if (Random().nextDouble() < 0.3) {
      throw Exception('Failed to fetch greeting');
    }
    return 'Hello from Async!';
  }
}
