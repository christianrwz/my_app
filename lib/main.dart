import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/async_notifier_provider/async_notifier_screen.dart';
import 'package:my_app/computed_provider/computed_screen.dart';
import 'package:my_app/fifth.dart';
import 'package:my_app/first.dart';
import 'package:my_app/fourth.dart';
import 'package:my_app/second.dart';
import 'package:my_app/select/select_list_screen.dart';
import 'package:my_app/select/select_simple_demo.dart';
import 'package:my_app/third.dart';
import 'package:my_app/third_example.dart';
import 'package:my_app/state_notifier_provider_counter/counter_screen.dart';
import 'package:my_app/state_notifier_provider_todo/todo_screen.dart';

void main() =>
    runApp(ProviderScope(child: MaterialApp(home: const CompareSelectScreen())));
