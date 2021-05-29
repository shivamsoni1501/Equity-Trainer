import 'package:firebase_auth/firebase_auth.dart';
import '../services/database.dart';
import '../models/user.dart';

class AuthenticationService {
  //defining firebase authenticating instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to connect on realtime with firebase
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign-in with email-password;
  Future signinEmailPassword(String email, String password) async {
    try {
      UserCredential rejult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (rejult == null) {
        return null;
      }
      User user = rejult.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  // Future varifyEmail() async {
  //   try {
  //     User user = _auth.currentUser;
  //     print('USER');
  //     if (!user.emailVerified) {
  //       await user.sendEmailVerification();
  //       print('USER not varified');

  //       return false;
  //     }
  //     print('USER VARIFIED');
  //     return true;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future updateName(String name) async {
  //   try {
  //     User user = _auth.currentUser;
  //     print('user');
  //     await user.updateProfile(displayName: name);
  //     print('user name');
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future updateEmail(String email) async {
  //   try {
  //     User user = _auth.currentUser;
  //     print('user');
  //     await user.updateEmail(email).then((value) => print('SUccessfull'));
  //     print('USER Email');
  //     return true;
  //   } catch (e) {
  //     return false;
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
      LocalUser.updateLocalUser(name, contact, email, password);
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
      LocalUser.clear();
      return await _auth.signOut();
    } catch (e) {
      return false;
    }
  }
}
