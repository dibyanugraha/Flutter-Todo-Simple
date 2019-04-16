import 'package:flutter/material.dart';
import 'package:todos/FancyFab.dart';
import 'package:todos/dac/DataAccess.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screen/AddTodoItemScreen.dart';
import 'package:todos/screen/TodoListScreen.dart';

class TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todos = List();
  DataAccess _dataAccess;

  TodoListScreenState() {
    _dataAccess = DataAccess();
  }

  @override
  initState() {
    super.initState();
    _dataAccess.open().then((result) {
      _dataAccess.getTodoItems().then((r) {
        setState(() {
          _todos = r;
        });
      });
    });
  }

  Widget _createTodoWidget(Todo todo) {
    return ListTile(
      title: Text(todo.name),
      trailing: Checkbox(
        value: todo.isComplete,
        onChanged: (value) => _updateTodoCompleteStatus(todo, value),
      ),
      onLongPress: () => _displayDeleteConfirmationDialog(todo),
    );
  }

  void _updateTodoCompleteStatus(Todo todo, bool newStatus) {
    todo.isComplete = newStatus;
    _dataAccess.updateTodo(todo);
    _dataAccess.getTodoItems().then((items) {
      setState(() {
        _todos = items;
      });
    });
  }

  void _deleteTodo(Todo todo) {
    _dataAccess.deleteTodo(todo);
    _dataAccess.getTodoItems().then((items) {
      setState(() {
        _todos = items;
      });
    });
  }

  void _addTodoItem() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoItemScreen()));
    _dataAccess.getTodoItems().then((r) {
      setState(() {
        _todos = r;
      });
    });
  }

  Future<Null> _displayDeleteConfirmationDialog(Todo todo) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true, // Allow dismiss when tapping away from dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete TODO"),
            content: Text("Do you want to delete \"${todo.name}\"?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: Navigator.of(context).pop, // Close dialog
              ),
              FlatButton(
                child: Text("Delete"),
                onPressed: () {
                  _deleteTodo(todo);
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final item = _todos[index];

          return Dismissible(
            key: Key(item.id.toString()),
            onDismissed: (direction) {
              setState(() {
                _todos.removeAt(index);
                _deleteTodo(item);
              });

              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("${item.name} deleted")));
            },
            background: Container(color: Colors.red),
            child: _todos.map(_createTodoWidget).elementAt(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
