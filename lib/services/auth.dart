import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  User _userFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser()).uid;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //    .map((FirebaseUser user) =>_userFirebase(user));
        .map(_userFirebase);
  }

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user= result.user;
      await DatabaseService(uid: user.uid).updateUserData('Name','Surname', 'Social','I like sport' );
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user= result.user;
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
