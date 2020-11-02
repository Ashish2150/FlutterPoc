import 'package:flutter/material.dart';
import 'package:flutter_firebase_poc/screens/add_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final _fireStore = Firestore.instance;

  // void getTodoTaskList() async {
  //   final tasks = await _fireStore.collection("ToDoData").getDocuments();
  //
  //   for (var task in tasks.documents) {
  //     print(task.data);
  //   }
  // }
  //
  // void getTodoUpdatedList() async {
  //   await for (var lists in _fireStore.collection("ToDoData").snapshots()) {
  //     for (var item in lists.documents) {
  //       print(item.data);
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getTodoTaskList();
    //getTodoUpdatedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: _fireStore
                  .collection("ToDoData")
                  .where('Email', isEqualTo: userEmail)
                  .snapshots(),
              builder: (context, lists) {
                print("list are $lists");
                if (lists.hasData) {
                  final todoTasks = lists.data.documents;
                  todoTasks.sort((a, b) {
                    return a['timeSpam'].compareTo(b['timeSpam']);
                  });
                  List<TaskData> taskWidgets = [];
                  for (var todo in todoTasks) {
                    final task = todo.data['task'];
                    final user = todo.data['Email'];
                    print("details are $task and $user");

                    final taskWidget =
                        TaskData(userEmail: user, taskContent: task);
                    taskWidgets.add(taskWidget);
                  }
                  return Expanded(
                    child: ListView(
                      children: taskWidgets,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Clicked on press button");
          debugPrint(userEmail);
          showModalBottomSheet<dynamic>(
            context: context,
            builder: (context) => AddTask(email: userEmail),
            isScrollControlled: true,
          );
        },
      ),
    );
  }
}

class TaskData extends StatelessWidget {
  TaskData({this.taskContent, this.userEmail});
  final String taskContent;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(9.0),
        child: Material(
            child: Text(
          '$taskContent from $userEmail',
          style: TextStyle(fontSize: 16.0),
        )));
    ;
  }
}
