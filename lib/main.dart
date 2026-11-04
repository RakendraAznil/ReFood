import 'package:flutter/material.dart';
import 'views/widgets/user/home_page_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReFood',
      home: const HomePageUser(),
    );
  }
}