import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'grokonez App',
      home: const MyHomePage(title: 'test Property data'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text(title)),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('properties').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Text(
                    '${ds['propertyname']}:\n${ds['propertyaddress']}\n---',
                    style: TextStyle(fontSize: 18.0),
                  );
                });
          }),
    );
  }
}
