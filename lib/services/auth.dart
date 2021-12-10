import 'dart:async';

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MUser? _userFromFirebaseUser(User? firebaseUser){
    return firebaseUser!=null? MUser(uid:firebaseUser.uid):null;
  }
  //sign in anonymously
  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //auth change user stream
  Stream<MUser?> get user{
    return _auth.authStateChanges()
      .map(_userFromFirebaseUser);
      }
  //sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email,String password) async{
    try {
      
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      //create new brew document with uid
      await DatabaseService(uid: result.user!.uid).updateUserData('0', 'new', 0);
      return _userFromFirebaseUser(result.user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}