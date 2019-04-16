import 'package:flutter/material.dart';
import 'package:todos/dac/DataAccess.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screen/AddTodoItemScreen.dart';

class AddTodoItemScreenState extends State<AddTodoItemScreen> {
  final _todoNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Add Todo'),
            centerTitle: true,
            backgroundColor: Colors.blue),
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                todoFormField(),
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
                        if (_formKey.currentState.validate()) {
                          DataAccess()
                              .insertTodo(Todo(name: _todoNameController.text));
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                )
              ],
            )));
  }

  final FocusNode _todoFocus = FocusNode();
  TextFormField todoFormField() {
    return TextFormField(
      controller: _todoNameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      focusNode: _todoFocus,
      onFieldSubmitted: (value) {
        _todoFocus.unfocus();
      },
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

  @override
  void dispose() {
    _todoNameController.dispose();
    super.dispose();
  }
}
