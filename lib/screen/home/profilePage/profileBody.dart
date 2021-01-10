import 'package:flutter/material.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/database.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic controller = TextEditingController();
  dynamic controllerN = TextEditingController();
  dynamic controllerE = TextEditingController();
  int index = 0;

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool readOn = false;
  toggle() {
    readOn = !readOn;
  }

  @override
  Widget build(BuildContext context) {
    controller.text = LocalUser.userData['name'];
    controllerN.text = LocalUser.userData['phone'];
    controllerE.text = LocalUser.userData['email'];
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: boxDecoration,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(30),
                  child: Icon(Icons.person, color: Colors.pink, size: 80),
                  radius: 60,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.pink,
                        ),
                      ),
                      Text(
                        "${LocalUser.tocken.floorToDouble()}",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.pink,
                ),
                IndexedStack(index: index, children: [
                  IconButton(
                    onPressed: () async {
                      if (readOn) {
                        setState(() {
                          index = 1;
                        });
                        LocalUser.userData['name'] = controller.text;
                        LocalUser.userData['phone'] = controllerN.text;
                        LocalUser.userData['email'] = controllerE.text;
                        await DatabaseService().updateDatabase();
                        print("succeded");
                      }
                      setState(() {
                        index = 0;
                        toggle();
                      });
                    },
                    color: Colors.pink,
                    icon: (!readOn) ? Icon(Icons.edit) : Icon(Icons.save),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                ]),
                // decoration: inputDecoration.copyWith(
                //     labelText: 'Name', hintText: "First Last"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    // boxShadow: [BoxShadow(color: Colors.pink, spreadRadius: 2)],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: readOn,
                        controller: controller,
                        cursorColor: Colors.pinkAccent,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                            color: Colors.pink,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          // border: null,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.pink,
                      ),
                      TextFormField(
                        enabled: readOn,
                        controller: controllerN,
                        cursorColor: Colors.pinkAccent,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.pink,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          // border: null,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.pink,
                      ),
                      TextFormField(
                        enabled: readOn,
                        controller: controllerE,
                        cursorColor: Colors.pinkAccent,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Colors.pink,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          // border: null,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
