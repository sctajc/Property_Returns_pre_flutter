import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Text('Tasks'),
                Text(
                    'Here is a summary of everything and things you need to do or consider'),
              ],
            ),
          ),
          Card(
            color: Colors.amber,
            child: Column(
              children: <Widget>[
                Text('Lease Events'),
                Text('Rent renewal - Smith & co - Due 1st April 2019')
              ],
            ),
          )
        ],
      ),
    );
  }
}
