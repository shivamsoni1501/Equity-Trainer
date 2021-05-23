import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/screen/home/HistoryPage/history.dart';
import 'package:hello_world/screen/home/homePage/homeBody.dart';
import 'package:hello_world/screen/home/profilePage/profileBody.dart';
import 'package:hello_world/screen/home/portfolioPage/portfolio.dart';
import 'package:hello_world/services/authentication.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DocumentSnapshot snapshot;
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    snapshot = Provider.of<DocumentSnapshot>(context);
    if (snapshot != null) {
      dynamic data = snapshot.data();

      data['stocks'].forEach((k, v) {
        v.forEach((k1, v1) {
          LocalUser.stocks[k][k1] = v1.toDouble();
        });
      });

      LocalUser.stockList.clear();
      data['stockList'].forEach((i) => LocalUser.stockList.add(i.toString()));

      LocalUser.stockList.forEach((element) {
        LocalUser.stocksHistory[element].clear();
      });

      LocalUser.history.clear();
      data['history'].forEach((i) {
        Map<String, String> map = Map();
        i.forEach((k, v) {
          map[k.toString()] = v.toString();
        });
        LocalUser.history.add(map);
        LocalUser.stocksHistory[map['stockId']].add(map);
      });

      data['userData'].forEach((k, v) {
        LocalUser.userData[k] = v.toString();
      });
      LocalUser.tocken = data['tocken'].toDouble();
    }
    super.didChangeDependencies();
  }

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
            onPressed: () async => await AuthenticationService().signout(),
            icon: Icon(Icons.logout),
            color: Colors.pink,
            iconSize: 30,
          )
        ],
      ),
      body: (_selectedIndex < 2)
          ? ((_selectedIndex == 0) ? HomePage() : History())
          : ((_selectedIndex == 2) ? Porfolio() : ProfilePage()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.pink,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: _selectedIndex,
        onTap: (val) {
          setState(() {
            switch (val) {
              case 0:
                _selectedIndex = 0;
                break;
              case 1:
                _selectedIndex = 1;
                break;
              case 2:
                _selectedIndex = 2;
                break;
              case 3:
                _selectedIndex = 3;
            }
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: "portfolio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
