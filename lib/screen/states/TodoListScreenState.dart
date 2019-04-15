import 'package:flutter/material.dart';
import 'package:todos/dac/DataAccess.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screen/TodoListScreen.dart';

class TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todos = List();
  DataAccess _dataAccess;

  TodoListScreenState() {
    _dataAccess = DataAccess();
  }

  // @override
  // initState() {
  //   super.initState();
  //   _dataAccess.open().then(
  //     (result) => _dataAccess.getTodoItems()
  //                   .then(
  //                     (todoList) => setState(() => _todos = todoList)
  //                   )
  //   );
  // }
@override
  initState() {
    super.initState();
    _dataAccess.open().then((result) { 
      _dataAccess.getTodoItems()
                .then((r) {
                  setState(() { _todos = r; });
                });
    });
  }
  void _addTodoItem() {}

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
    final tempTodoItems = _todos;
    tempTodoItems.firstWhere((i) => i.id == todo.id).isComplete = newStatus;
    setState(() {
      _todos = tempTodoItems;
    });
    // TODO: Persist change
  }

  void _deleteTodo(Todo todo) {
    final tempTodoItems = _todos;
    tempTodoItems.remove(todo);
    setState(() {
      _todos = tempTodoItems;
    });
    // TODO: Persist change
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
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify Widgets.
            key: Key(item.id.toString()),
            // We also need to provide a function that tells our app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from our data source.
              setState(() {
                _todos.removeAt(index);
              });

              // Then show a snackbar!
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away
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
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
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
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
