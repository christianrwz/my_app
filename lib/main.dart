import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/first.dart';
import 'package:my_app/fourth.dart';
import 'package:my_app/second.dart';
import 'package:my_app/third.dart';
import 'package:my_app/third_example.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: const GreetingScreen())));
}
