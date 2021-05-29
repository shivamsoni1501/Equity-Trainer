import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

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

  Stream<DocumentSnapshot> get userData {
    return databaseCollection.doc(LocalUser.uid).snapshots();
  }
}
