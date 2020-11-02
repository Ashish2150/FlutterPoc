import 'package:flutter/material.dart';
import 'package:flutter_firebase_poc/screens/login_screen.dart';
import 'package:flutter_firebase_poc/screens/registration_screen.dart';
import 'package:flutter_firebase_poc/screens/todo_screen.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: FirebaseLaunch(),
      initialRoute: '/',
      routes: {
        '/': (context) => FirebaseLaunch(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        TodoScreen.id: (context) => TodoScreen()
      },
    );
  }
}

class FirebaseLaunch extends StatefulWidget {
  @override
  _FirebaseLaunchState createState() => _FirebaseLaunchState();
}

class _FirebaseLaunchState extends State<FirebaseLaunch>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    //Fade Animation...
//    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();
    //animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.addListener(() {
      setState(() {
        debugPrint("${controller.value}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "100",
                child: Container(
                  child: Image.asset(
                    "images/logo.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(height: 30),
              RaisedButton(
                color: Colors.blueAccent.withOpacity(controller.value),
                child: Text("Login"),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              RaisedButton(
                child: Text("Registration"),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                  debugPrint("Clicked on the ");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
