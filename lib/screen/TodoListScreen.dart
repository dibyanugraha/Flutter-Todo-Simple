import 'package:flutter/material.dart';
import 'package:todos/screen/states/TodoListScreenState.dart';

class TodoListScreen extends StatefulWidget {
  TodoListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  TodoListScreenState createState() => new TodoListScreenState();
}