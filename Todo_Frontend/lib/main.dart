import 'package:flutter/material.dart';
import 'screens/todo_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 125, 13, 96),
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0F172A),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF14B8A6),
    secondary: Color(0xFF38BDF8),
  ),
  cardColor: const Color(0xFF1E293B),
),

      home: const TodoHome(),
    );
  }
}
