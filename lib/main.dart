import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app_binding/app_binding.dart';

import 'View/quiz_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizForm(),
    );
  }
}
