import 'package:flutter/material.dart';
import './auth.dart';

class HomePage extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  HomePage({this.auth, this.onSignedOut});
  void _signedOut() async{
    try{
      await auth.signOut();
      onSignedOut();
      print("Succesfully signed out!");

    }catch(e){
      print("error $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
          actions: <Widget>[    
              
              Center(child: Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))), 
              IconButton( 
                onPressed: _signedOut,
                color: Colors.amberAccent,
                icon: Icon(Icons.remove_circle_outline)
              ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome back user !", style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,)
              
            ],
          ),
      ),
    );
  }
}