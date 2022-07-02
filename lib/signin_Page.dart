import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'googlePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn _googleSinIn = GoogleSignIn();

class SignInPage extends StatefulWidget {
  final String title = 'Registrarse';
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return FlatButton(
                child: const Text('Sign out / Desconectar '),
                onPressed: () async {
                  final User user = await _auth.currentUser!;
                  _signOut();
                },
              );
            })
          ],
        ),
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                GoogleSignInSection(),
              ],
            );
          },
        ));
  }

  void _signOut() async {
    await _auth.signOut();
  }
}

class GoogleSignInSection extends StatefulWidget {
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<GoogleSignInSection> {
  late bool _success;
  late String _userID;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: const Text('Test sign in with Google'),
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {
                  _signInWithGoogle();
                },
              )
            ],
          ),
        )
      ],
    );
  }

  void _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSinIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final User user = (await _auth.signInWithCredential(credential)) as User;
    assert(user.displayName != null);
    assert(await user.getIdToken() != null);

    final User currentUser = await _auth.currentUser!;
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _success = true;
        _userID = user.uid;
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (context) => MainGoogle(),
        ));
      }
    });
  }
}
