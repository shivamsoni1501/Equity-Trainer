import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './models/constants.dart';
import './screen/wrapper.dart';
import './services/authentication.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
        title: 'Equity Trainer',
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: customColorScheme,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              color: Colors.pink,
              fontWeight: FontWeight.w900,
              textBaseline: TextBaseline.alphabetic,
              decoration: TextDecoration.none,
            ),
            headline2: TextStyle(
              fontSize: 20,
              color: Colors.pink.shade700,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
              decoration: TextDecoration.none,
            ),
            headline3: TextStyle(
              fontSize: 18,
              color: Colors.pink.shade700,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
              decoration: TextDecoration.none,
            ),
            headline4: TextStyle(
              fontSize: 16,
              color: Colors.white60,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
              decoration: TextDecoration.none,
            ),
            headline5: TextStyle(
              fontSize: 14,
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
              decoration: TextDecoration.none,
            ),
            headline6: TextStyle(
              fontSize: 12,
              color: Colors.white30,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
              decoration: TextDecoration.none,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
