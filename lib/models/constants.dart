import 'package:flutter/material.dart';
import 'package:hello_world/services/authentication.dart';

// Color Themes
ColorScheme customColorScheme = ColorScheme(
  primary: customColors['dark'][2],
  primaryVariant: customColors['dark'][4],
  secondary: customColors['primary'][1],
  secondaryVariant: customColors['primary'][2],
  surface: customColors['dark'][1],
  background: customColors['dark'][0],
  error: Colors.redAccent,
  onPrimary: customColors['primary'][2],
  onSecondary: customColors['dark'][0],
  onSurface: customColors['primary'][1],
  onBackground: customColors['primary'][0],
  onError: customColors['dark'][0],
  brightness: Brightness.light,
);
// const color = Color(0xff012352);
const Map<String, List<Color>> customColors = {
  'primary': [Color(0xFFFFC1E3), Color(0xFFF48FB1), Color(0xFFBF5F82)],
  'dark': [
    Color(0xFF121212),
    Color(0xFF1D1D1D),
    Color(0xFF212121),
    Color(0xFF242424),
    Color(0xFF262626),
    Color(0xFF2C2C2C),
    Color(0xFF2D2D2D),
    Color(0xFF323232),
    Color(0xFF353535),
    Color(0xFF373737)
  ],
};

bool wait = false;

Map<String, Map<String, dynamic>> quoteRaw;
final List<String> requestC = [
  'AAPL',
  'GOOG',
  'MSFT',
  'AMZN',
  'FB',
  'TSLA',
  'BABA',
  'V',
  'NFLX',
  'NKE'
];

Text textL(String val) => Text(
      val,
      style: TextStyle(color: Colors.grey, fontSize: 10),
    );

Text textR(String val) => Text(
      val,
      style: TextStyle(
          color: Colors.pink, fontSize: 25, fontWeight: FontWeight.w600),
    );

Widget appBar(Icon icon, String path, BuildContext context) => AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      shadowColor: Colors.pink,
      elevation: 20,
      title: Text(
        "EQUITY TRAINER",
        style: TextStyle(color: Colors.pink),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            if (path == '/exit') {
              dynamic result = await AuthenticationService().signout();
              if (result == false) {
              } else {
                // Navigator.pushReplacementNamed(context, '/signin');
                print("logout");
              }
            } else {}
          },
          icon: icon,
          color: Colors.pink,
          iconSize: 30,
        )
      ],
    );

//---------------------------FORM------------------------------------
//Form Box Decoration
final boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.elliptical(300, 140),
        topRight: Radius.elliptical(300, 140),
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40)),
    color: customColorScheme.surface,
    boxShadow: [
      BoxShadow(
        color: Colors.black54,
        blurRadius: 5,
        offset: Offset(4, 4),
        spreadRadius: 1,
      )
    ]);

//Icon
Widget icon(IconData icon) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 20),
          child: Icon(icon, color: Colors.pink, size: 50),
        ),
        Divider(
          height: 20,
          thickness: 2,
          color: Colors.pink,
        ),
        SizedBox(height: 20),
      ],
    );

//Input Text
const textStyle =
    TextStyle(color: Colors.pink, fontSize: 15, fontWeight: FontWeight.bold);

final InputDecoration inputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey.shade700),
  labelStyle: TextStyle(
    color: Colors.pink,
  ),
  errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red[900])),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red[900], width: 2)),
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade700)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2)),
);

//-------------------------------END--------------------------------------

final profileBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.vertical(
        top: Radius.circular(50), bottom: Radius.circular(20)),
    color: Colors.black,
    boxShadow: [
      BoxShadow(
        color: Colors.pink.shade200,
        blurRadius: 2,
        spreadRadius: 2,
        offset: Offset(2, 2),
      )
    ]);
