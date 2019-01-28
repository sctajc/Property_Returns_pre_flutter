import 'package:flutter/material.dart';

class ToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do list. Things without any dates times'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text('Show To do list'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () => Navigator.pop(context)),
      ),
    );
  }
}
