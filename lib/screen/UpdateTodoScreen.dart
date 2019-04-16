import 'package:flutter/material.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screen/states/UpdateTodoScreenState.dart';

class UpdateTodoScreen extends StatefulWidget {
  final Todo todo;
  
  UpdateTodoScreen(
    {this.todo}
  );

  @override
  createState() => UpdateTodoScreenState(todo: todo);
}
