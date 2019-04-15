import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos/FancyFab.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Todo Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(title: 'Todo List'),
    );
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(5, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    final title = 'Todo List';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify Widgets.
              key: Key(item),
              // We also need to provide a function that tells our app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from our data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar!
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text('$item'),
                trailing: Icon(
                  Icons.check_box,
                  color: Colors.blue,
                ),
                onTap: () => Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('$item'))),
              ),
            );
          },
        ),
        floatingActionButton: FancyFab(onPressed: null, tooltip: 'Increment'),
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
      ),
    );
  }
}
