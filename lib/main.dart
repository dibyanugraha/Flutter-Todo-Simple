import 'package:flutter/material.dart';
import 'package:todos/screen/TodoListScreen.dart';

void main() {
  runApp(MyApp());
}

// MyApp is a StatefulWidget. This allows us to update the state of the
// Widget whenever an item is removed.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(title: 'Todo List'),
    );
  }
}
