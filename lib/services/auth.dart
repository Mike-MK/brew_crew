import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebaseUser(FirebaseUser firebaseUser){
    return User(uid:firebaseUser.uid);
  }
  //sign in anonymously
  Future signInAnon() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //auth change user stream
  Stream<User?> get user{
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }
  //sign in with email and password

  //register with email and password

  //signout
}