import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos_app/pages/todos_page.dart';

void main() async {
  await Hive.initFlutter();

  // open a openbox
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodosPage(),
      theme: ThemeData(primaryColor: const Color(0x009C31FF)),
    );
  }
}
