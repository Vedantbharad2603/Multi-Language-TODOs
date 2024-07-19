import 'package:flutter/material.dart';
import 'package:todo_app/home_page.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // translations: MyTranslations(),
      // locale: Get.deviceLocale,
      home: TodoScreen(),
    );
  }
}

