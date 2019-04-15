
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Todo extends Equatable {
  int id;
  final String name;
  bool isComplete;

  Todo({this.id, @required this.name, this.isComplete = false});
  
  Todo.fromMap(Map<String, dynamic> map)
  : id = map["id"],
    name = map["name"],
    isComplete = map["isComplete"] == 1;  

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": name,
      "isComplete": isComplete ? 1 : 0
    };
    // Allow for auto-increment
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}