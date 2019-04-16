import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:todos/models/todo.dart';

final String todoTable = "Todos";

class DataAccess {
  static final DataAccess _instance = DataAccess._internal();
  Database _db;

  factory DataAccess() {
    return _instance;
  }

  DataAccess._internal();

  Future open() async {

    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "\\todos.db";

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $todoTable ( 
            id integer primary key autoincrement, 
            name text not null,
            isComplete integer not null)
            ''');
    });

    if((await getTodos()).length == 0) {      
      insertTodo(Todo(name: "Create First Todo", isComplete: true));
      insertTodo(Todo(name: "Run a Marathon"));
      insertTodo(Todo(name: "Create Todo_Flutter blog post"));
    }
  }

  Future<List<Todo>> getTodos() async {
    var data = await _db.query(todoTable);
    return data.map((d) => Todo.fromMap(d)).toList();
  }

  Future<Todo> getTodo(String name) async {
    var data = await _db.query(todoTable);
    return data.map((d) => Todo.fromMap(d)).firstWhere((t) => t.name == name);
  }

  Future insertTodo(Todo item) {
    return _db.insert(todoTable, item.toMap());
  }

  Future updateTodo(Todo item) {
    return _db.update(todoTable, item.toMap(),
      where: "id = ?", whereArgs: [item.id]);
  }
  
  Future deleteTodo(Todo item) {
    return _db.delete(todoTable, where: "id = ?", whereArgs: [item.id]);
  }
}