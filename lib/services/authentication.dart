import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/database.dart';

class AuthenticationService {
  //defining firebase authenticating instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //converting firebase User to Local_User

  // Stream to connect on realtime with firebase
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign-in with anonymous;
  // Future signinAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User _user = result.user;
  //     return localUserFromUser(_user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign-in with email-password;
  Future signinEmailPassword(String email, String password) async {
    try {
      UserCredential rejult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = rejult.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  // Future updateEmail(String email) async{
  //   try{
  //     UserCredential rejult = await _auth
  //   }catch(e){
  //   }
  // }

  //register via email-password;
  Future registerEmailPassword(
      String name, String contact, String email, String password) async {
    try {
      UserCredential rejult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = rejult.user;

      // update Local User
      LocalUser.uid = user.uid;
      LocalUser.userData['contact'] = contact;
      LocalUser.userData['name'] = name;
      LocalUser.userData['email'] = email;
      LocalUser.userData['password'] = password;
      LocalUser.tocken = 100000;

      // DatabaseService.uid = user.uid;
      await DatabaseService().updateDatabase();
      return user;
    } catch (e) {
      return null;
    }
  }

  // sign-out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return false;
    }
  }
}
