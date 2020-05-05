import 'package:flutter/material.dart';
import './auth.dart';
class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  LoginPage({this.auth, this.onSignedIn});
  @override
  _LoginPageState createState() => _LoginPageState();

}
enum FormType{
  login, 
  register
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _pw;
  final _formkey = GlobalKey<FormState>();

  FormType _formtype = FormType.login;
  
  bool _validateSave(){
    final _form  = _formkey.currentState;
    if(_form.validate()){
      _form.save();
      return true;
    }else{
      return false;
    }
  }
  void saveUpdate() async{
    if(_validateSave()){
      try{
        if(_formtype == FormType.login){
          String user = await widget.auth.signInWithEmailAndPassword(_email, _pw);
          print('Successful login $user');
          }else{
          String user = await widget.auth.createUserWithEmailAndPassword(_email, _pw);
            print('Successfully registered $user');
          }
          widget.onSignedIn();
      }catch(e){
        print("error: $e");
      }

    }
  }
  void moveRegisterPage(){
    _formkey.currentState.reset();
    setState(() {
      _formtype = FormType.register;
    });
  }
   void moveLoginPage(){
     _formkey.currentState.reset();
    setState(() {
      _formtype = FormType.login;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(  
        elevation: 6,
        title: Text("Flutter login demo"),
      ),
      body: Container( 
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildinputs() +buildsubmitbuttons(),
          ),
          )
      )

    );
  }
  List<Widget> buildinputs(){
    return [
      TextFormField( 
        validator: (val) {
          if(val.isEmpty){
            return "Email can't be empty";
          }
          return null;
        },
        onSaved: (val) => _email = val,
        decoration: InputDecoration(
          labelText: 'Email',
        ),
      ),
      SizedBox( 
        height: 15,
      ),
      // Password field
      TextFormField( 
        obscureText: true,
        validator: (val) {
          if(val.length < 6){
            return "Min 6 characters";
          }
          return null;
        },
        onSaved: (val) => _pw = val,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
      ),];
  }
  List <Widget> buildsubmitbuttons(){
    if(_formtype == FormType.login){
      return [  
        SizedBox(height: 10,),
        RaisedButton( 
          onPressed: saveUpdate,
          child: Text("Login", style: TextStyle(fontSize: 18),),
        ),              
        FlatButton(
          onPressed: moveRegisterPage,
          child: Text("create new account", style: TextStyle(color: Colors.grey),)
        )];
    }else{
      return [  
        SizedBox(height: 10,),
        RaisedButton( 
          onPressed: saveUpdate,
          child: Text("Create new account", style: TextStyle(fontSize: 18),),
        ),              
        FlatButton(
          onPressed: moveLoginPage,
          child: Text("Have an account? Login", style: TextStyle(color: Colors.grey),)
        )];
    }
  }
}