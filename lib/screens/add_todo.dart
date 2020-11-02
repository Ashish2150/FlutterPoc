import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AddTask extends StatefulWidget {
  final String email;
  AddTask({Key key, @required this.email}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState(this.email);
}

class _AddTaskState extends State<AddTask> {
  String firebaseEmail;
  _AddTaskState(this.firebaseEmail);

  TextEditingController taskTextField = TextEditingController();
  String textTask;
  final _fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Add Task -",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    hintText: "Enter Task Name",
                    isDense: true),
                onChanged: (value) {
                  textTask = value;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text("Submit"),
                    onPressed: () {
                      try {
                        _fireStore.collection("ToDoData").add({
                          "isCompleter": false,
                          "Email": firebaseEmail,
                          "task": textTask,
                          "time": "1 day",
                          "timeSpam": DateTime.now().millisecondsSinceEpoch
                        });
                        Navigator.pop(context);
                      } on PlatformException catch (e) {
                        debugPrint(e.message);
                      }
                    },
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
