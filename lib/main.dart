import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/extensions.dart';
import 'package:my_app/login_form.dart';
import 'package:my_app/services.dart';
import 'package:my_app/text_collapse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Custom Form Field Example")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextCollapse(),
        ),
      ),
    );
  }
}
