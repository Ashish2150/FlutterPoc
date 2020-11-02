import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_poc/screens/todo_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _snackKey = GlobalKey();

  TextEditingController emailController = new TextEditingController();

  bool isLogin = false;

  String email;
  String password;

  final _auth = FirebaseAuth.instance;
/**
 * this method for autologin ....
 *
  void autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userName = prefs.getString("email");

    if (userName != null) {
      setState(() {
        isLogin = true;
        email = userName;
        //emailController.text = userName;
      });
    }
  }
  */

  // Future<Null> loginUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // prefs.setString('email', emailController.text);
  //   prefs.setString('email', email);
  //
  //   setState(() {
  //     email = "";
  //     isLogin = true;
  //   });
  //
  //   emailController.clear();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _snackKey,
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 20.0, height: 100.0),
                      Text(
                        "Be",
                        style: TextStyle(fontSize: 43.0),
                      ),
                      SizedBox(width: 20.0, height: 100.0),
                      RotateAnimatedTextKit(
                          onTap: () {
                            print("Tap Event");
                          },
                          text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
                          textStyle:
                              TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                          textAlign: TextAlign.start),
                    ],
                  ),
                  Hero(
                    tag: "100",
                    child: Container(
                      child: Image.asset(
                        "images/logo.png",
                        height: 180,
                        width: 180,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          //hintText: "Enter User Name",
                          isDense: true,
                          labelText: "Enter User Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          //hintText: "Enter Password",
                          labelText: "Enter Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                    height: 50,
                    child: RaisedButton(
                      child: isLogin
                          ? Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () async {
                        print(email);
                        print(password);
                        try {
                          final userDetil =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);

                          if (userDetil != null) {
                            print("User is ${userDetil.user.uid}");
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoScreen(
                                        userEmail: email,
                                      )));
                        } on PlatformException catch (e) {
                          debugPrint("${e.message}");
                          final snackBarMessage =
                              SnackBar(content: Text(e.message));
                          _snackKey.currentState.showSnackBar(snackBarMessage);
                        }

                        debugPrint("Value of text is ${emailController.text}");
                        //Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
