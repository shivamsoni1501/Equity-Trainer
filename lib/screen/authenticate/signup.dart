import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/services/authentication.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool _load = false;

  String name;
  String number;
  String email;
  String password;
  String error = '';

  FocusNode nameNode = FocusNode();
  FocusNode numberNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

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
        elevation: 20,
        title: Text(
          "EQUITY MANAGER",
          style: TextStyle(color: Colors.pink),
        ),
        actions: [
          IconButton(
            onPressed: () {
              this.widget.toggle();
            },
            icon: Icon(
              Icons.login,
              color: Colors.pink,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: boxDecoration,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  icon(Icons.person_add_alt_1),
                  TextFormField(
                    focusNode: nameNode,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(numberNode);
                    },
                    keyboardType: TextInputType.name,
                    onChanged: (val) => name = val,
                    validator: (val) =>
                        val.isNotEmpty ? null : 'Enter a valide Name',
                    style: textStyle,
                    decoration: inputDecoration.copyWith(
                        labelText: 'Name', hintText: "First Last"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    focusNode: numberNode,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(emailNode);
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (val) => number = val,
                    validator: (val) =>
                        val.length == 10 ? null : 'Enter a valide Number',
                    style: textStyle,
                    decoration: inputDecoration.copyWith(
                        labelText: 'Number', hintText: "xxxxxxxxxx"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    focusNode: emailNode,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(passwordNode);
                    },
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => email = val,
                    validator: (val) =>
                        val.contains("@") ? null : 'Enter a valide Email',
                    style: textStyle,
                    decoration: inputDecoration.copyWith(
                        labelText: 'Email', hintText: "user@example.com"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    focusNode: passwordNode,
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) =>
                        val.length > 7 ? null : 'Enter a valide Password',
                    style: textStyle,
                    decoration: inputDecoration.copyWith(
                        hintText: "Min 8 Char long", labelText: "Password"),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          error = '';
                          _load = true;
                        });
                        dynamic result = await AuthenticationService()
                            .registerEmailPassword(
                                name, number, email, password);
                        if (result == null) {
                          setState(() {
                            _load = false;
                            error =
                                "Failed to register!\nTry a different Email Id.";
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
                      "REGISTER",
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
    );
  }
}
