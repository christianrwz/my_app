import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/fifth.dart';
import 'package:my_app/first.dart';
import 'package:my_app/fourth.dart';
import 'package:my_app/second.dart';
import 'package:my_app/third.dart';
import 'package:my_app/third_example.dart';
import 'package:my_app/counter/counter_screen.dart';
import 'package:my_app/todo/todo_screen.dart';

void main() =>
    runApp(ProviderScope(child: MaterialApp(home: const TodoScreen())));
