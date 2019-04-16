import 'package:flutter/material.dart';
import 'package:todos/dac/DataAccess.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screen/UpdateTodoScreen.dart';

class UpdateTodoScreenState extends State<UpdateTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final Todo todo;
  UpdateTodoScreenState(
    {this.todo}
  );

  final _todoNameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    _todoNameController.text = todo.name;
    return Scaffold(
        appBar: AppBar(
            title: Text('Update Todo'),
            centerTitle: true,
            backgroundColor: Colors.blue),
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                todoFormField(todo),
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
                      child: Text("Update"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          updateTodo(todo);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                )
              ],
            )));
  }

  TextFormField todoFormField(Todo todo) {
    return TextFormField(
      controller: _todoNameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter todo name!';
        }
      },
      decoration: InputDecoration(
        icon: Icon(Icons.note_add),
        fillColor: Colors.white,
        labelText: 'Todo Name',
      ),
    );
  }
  List<Todo> _todos = List();
  @override
  void dispose() {
    _todoNameController.dispose();
    super.dispose();
  }
  
  void updateTodo(Todo todo) {
    todo.name = _todoNameController.text;
    DataAccess().updateTodo(todo);
    DataAccess().getTodos().then((items) {
      setState(() {
        _todos = items;
      });
    });
  }
}
