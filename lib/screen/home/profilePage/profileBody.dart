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
        physics: BouncingScrollPhysics(),
        child: Container(
          width: 400,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: boxDecoration,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: customColorScheme.background,
                  child: Icon(Icons.person, color: Colors.white60, size: 80),
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
                          color: Colors.white30,
                        ),
                      ),
                      Text(
                        "${LocalUser.tocken.floorToDouble()}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.grey[800],
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
                        // print('DATABASE');
                        // if (LocalUser.userData['name'] != controller.text) {
                        //   await AuthenticationService()
                        //       .updateName(controller.text);
                        //   print('NAME');
                        // }

                        // if (LocalUser.userData['email'] != controllerE.text) {
                        //   await AuthenticationService()
                        //       .updateEmail(controllerE.text);
                        //   print('EMAIL');

                        //   await AuthenticationService().varifyEmail();
                        //   print('VARIFICATION SENT');
                        // }
                        // print('SSSSSSSSSSSSSSSSSSSSSSss');
                      }
                      setState(() {
                        index = 0;
                        toggle();
                      });
                    },
                    color: Colors.white60,
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
                    color: customColorScheme.background,
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
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w900, letterSpacing: 2),
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
                            color: Colors.white60,
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey[800],
                      ),
                      TextFormField(
                        enabled: readOn,
                        controller: controllerN,
                        cursorColor: Colors.pinkAccent,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w900, letterSpacing: 2),
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
                            color: Colors.white60,
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey[800],
                      ),
                      TextFormField(
                        enabled: false,
                        controller: controllerE,
                        cursorColor: Colors.pinkAccent,
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w900, letterSpacing: 2),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white60,
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
