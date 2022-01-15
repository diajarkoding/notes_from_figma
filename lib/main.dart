import 'package:flutter/material.dart';
import 'package:notes_from_figma/pages/home_page_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePageTwo());
  }
}
