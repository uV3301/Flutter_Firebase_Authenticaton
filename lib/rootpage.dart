import 'package:flutter/material.dart';
import 'package:login_firebase_demo/homepage.dart';
import './auth.dart';
import './LoginPage.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  _RootPageState createState() => _RootPageState();
}
enum SignIO{
  signedIn,
  signedOut
}

class _RootPageState extends State<RootPage> {
  var _signio = SignIO.signedOut;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((userid){
      setState(() {
        _signio = userid == null ? SignIO.signedOut : SignIO.signedIn; 
      });
    });
  }
  void _signoutDone(){
    setState(() {
      _signio = SignIO.signedOut;
    });
  }
  void _signinDone(){
    setState(() {
      _signio = SignIO.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _signio == SignIO.signedIn?
      HomePage(auth: widget.auth, onSignedOut: _signoutDone,)

    :LoginPage(auth: widget.auth, onSignedIn: _signinDone,)
    ;
  }
}