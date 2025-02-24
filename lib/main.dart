import 'package:exceltest/home_page.dart';
import 'package:exceltest/sqldb.dart';
import 'package:flutter/material.dart';
import 'file_excel_create.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
