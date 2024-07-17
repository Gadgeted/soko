import 'package:flutter/material.dart';
import 'productPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soko App',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define light theme colors and styles here
      ),
      darkTheme: ThemeData.dark(), // Define dark theme colors and styles here
      home: ProductsPage(), // Entry point to the Products page
    );
  }
}

