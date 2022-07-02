// ignore: file_names
import 'package:flutter/material.dart';

class EmailScreem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailScreemState();
}

class _EmailScreemState extends State<EmailScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Email Auth'),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(5.0),
            width: 400.0,
            height: 400.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assetName"), fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
