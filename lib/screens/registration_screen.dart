import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name;
  String email;
  String password;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Register your self...",
                  style: TextStyle(fontSize: 22.0),
                ),
                height: 50,
              ),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    labelText: "Enter Name",
                    isDense: true),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    labelText: "Enter Email",
                    isDense: true),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    labelText: "Enter Password",
                    isDense: true),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RaisedButton(
                      child: Text("Register"),
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          print("New user is $newUser");
                        } on PlatformException catch (e) {
                          debugPrint("${e.message}");
                          final snackBar =
                              new SnackBar(content: Text(e.message));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        }

                        debugPrint("Clicked on register button");
                        debugPrint("data is $name $email and $password");
                        //Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Back"),
                        onPressed: () {
                          Navigator.pop(context);
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
