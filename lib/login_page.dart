import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildsInput() + buildSubmitsButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildsInput() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitsButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          color: Color(0XFFFF0000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: Text("Register", style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        RaisedButton(
          color: Color(0XFFFF0000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: Text("Have you a account?", style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        )
      ];
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print("Sign with $userId");
        } else {
          String user = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print("Create with $user");
        }
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }
}
