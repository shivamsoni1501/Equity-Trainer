import 'package:flutter/material.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/services/authentication.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle()});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  FocusNode passwordNode = FocusNode();

  String email;
  String password;
  String error = '';
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        shadowColor: Colors.pink,
        elevation: 10,
        title: Text(
          "EQUITY TRAINER",
          style: TextStyle(color: Colors.pink),
        ),
        actions: [
          IconButton(
            onPressed: () {
              this.widget.toggle();
            },
            icon: Icon(
              Icons.app_registration,
              color: Colors.pink,
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: boxDecoration,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    icon(Icons.person),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).requestFocus(passwordNode);
                      },
                      onChanged: (val) => email = val,
                      validator: (val) =>
                          val.contains("@") ? null : 'Enter a valide Email',
                      style: textStyle,
                      decoration: inputDecoration.copyWith(labelText: 'Email'),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      focusNode: passwordNode,
                      onChanged: (val) => password = val,
                      validator: (val) =>
                          val.length > 7 ? null : 'Enter a valide Password',
                      style: textStyle,
                      decoration:
                          inputDecoration.copyWith(labelText: "Password"),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          error = "Failed to Login, Try again!";
                          setState(() {
                            _load = true;
                          });
                          dynamic result = await AuthenticationService()
                              .signinEmailPassword(email, password);
                          if (result == null) {
                            setState(() {
                              _load = false;
                            });
                          } else {}
                        }
                      },
                      color: Colors.pink.withOpacity(.2),
                      highlightColor: Colors.pink.withOpacity(.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.pink),
                      ),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.pink, letterSpacing: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (_load)
                              ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                )
                              : Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
