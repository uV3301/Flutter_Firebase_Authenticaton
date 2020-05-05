import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  Future<String> createUserWithEmailAndPassword(String email, String pw);
  Future<String> signInWithEmailAndPassword(String email, String pw);
  Future<String> currentUser();
  Future<void> signOut();

}
class Auth implements BaseAuth{
  Future<String> createUserWithEmailAndPassword(String email, String pw) async{
    FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pw)).user;
    return user.uid;
  }
  Future <String> signInWithEmailAndPassword(String email, String pw) async {
    FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.toString().trim(), password: pw)).user;
    return user.uid;
  }
  Future<String> currentUser() async{
    FirebaseUser user = (await FirebaseAuth.instance.currentUser());
    return user.uid;
  }
  Future<void> signOut() async{
    return FirebaseAuth.instance.signOut();
  }
}