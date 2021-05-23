import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/screen/authenticate/auth.dart';
import 'package:hello_world/screen/home/home.dart';
import 'package:hello_world/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    if (_user == null) {
      return Auth();
    } else {
      if (LocalUser.uid != _user.uid) {
        LocalUser.uid = _user.uid;
      }
      return StreamProvider<DocumentSnapshot>.value(
        value: DatabaseService().userData,
        child: Home(),
      );
    }
  }
}
