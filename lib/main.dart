import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_baby/emailPage.dart';
import 'package:first_baby/registerPage.dart';
import 'package:first_baby/signin_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' First Baby',
      home: LoginPage(title: 'WELCOME - LOGIN'),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration:
                  InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Password', icon: Icon(Icons.vpn_key)),
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                )
                    .then((user) {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => EmailScreem(),
                  ));
                }).catchError((e) {
                  print(e);
                });
              },
              color: Colors.orangeAccent,
              textColor: Colors.white,
              child: Text('Login'),
            ),
            FlatButton(
              onPressed: () => _pushPage(context, RegisterPage()),
              child: Text('Register'),
              color: Colors.green,
              textColor: Colors.white,
            ),
            VerticalDivider(),
            FlatButton(
              onPressed: () => _pushPage(context, SignInPage()),
              child: Text('Login'),
              color: Colors.green,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => page),
  );
}
