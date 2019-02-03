import 'package:flutter/material.dart';
import 'auth.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  void _onSignedOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          FlatButton(
            child: Text("LogOut",style: TextStyle(fontSize: 16.0,color: Colors.white),),
            onPressed: _onSignedOut,
          )
        ],
      ),
      body: Container(
        child: Container(
          child: Text("Welcome", style: TextStyle(fontSize: 32.0)),
        ),
      ),
    );
  }
}
