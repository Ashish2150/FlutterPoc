import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  static String id = "todo_screen";
  final String userEmail;
  TodoScreen({Key key, @required this.userEmail}) : super(key: key);
  @override
  _TodoScreenState createState() => _TodoScreenState(userEmail);
}

class _TodoScreenState extends State<TodoScreen> {
  String userEmail;

  _TodoScreenState(this.userEmail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Text(userEmail),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Clicked on press button");
        },
      ),
    );
  }
}
