import 'package:flutter/material.dart';
import 'package:hello_world/screen/authenticate/signin.dart';
import 'package:hello_world/screen/authenticate/signup.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool inOut = true;
  void toggle() {
    setState(() {
      inOut = !inOut;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (inOut) {
      return SignIn(toggle: toggle);
    } else {
      return SignUp(toggle: toggle);
    }
  }
}
