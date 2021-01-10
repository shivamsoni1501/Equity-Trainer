import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/models/user.dart';

class DatabaseService {
  static String uid;

  // DatabaseService({this.uid});

  //defining Database ccollection reference
  final CollectionReference databaseCollection =
      FirebaseFirestore.instance.collection("Equity");

  Future updateDatabase() async {
    return await databaseCollection.doc(LocalUser.uid).set({
      'userData': LocalUser.userData,
      'tocken': LocalUser.tocken,
      'stocks': LocalUser.stocks,
      'history': LocalUser.history,
      'stockList': LocalUser.stockList
    });
  }

  // //afterLogin
  // Future updateDatabaseA(String name, String number, String email) async {
  //   return await databaseCollection.doc(uid).set(
  //       {'name': name, 'number': number, 'email': email, "tocken": 100000});
  // }

  // Future<DocumentSnapshot> getUserData() async {
  //   return databaseCollection.doc(uid).get();
  // }

  Stream<DocumentSnapshot> get userData {
    return databaseCollection.doc(LocalUser.uid).snapshots();
  }
}
