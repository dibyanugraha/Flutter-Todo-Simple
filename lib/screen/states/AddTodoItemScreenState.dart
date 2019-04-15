import 'package:flutter/material.dart';
import 'package:todos/dac/DataAccess.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screen/AddTodoItemScreen.dart';

class AddTodoItemScreenState extends State<AddTodoItemScreen> {
  final _todoNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Todo Item")),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(labelText: "Todo Name"),
                    controller: _todoNameController,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text("Save"),
                      onPressed: () {
                        DataAccess().insertTodo(Todo(name: _todoNameController.text));
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )));
  }

  @override
  void dispose() {
    _todoNameController.dispose();
    super.dispose();
  }
}
