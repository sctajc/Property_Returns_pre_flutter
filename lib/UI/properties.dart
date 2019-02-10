import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Propertiess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Your Properties')),
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

class Properties extends StatelessWidget {
  Widget _property(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            document['propertyname'],
            style: Theme.of(context).textTheme.headline,
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      // Display all properties
      body: StreamBuilder(
          stream: Firestore.instance.collection('properties').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading');
            return ListView.builder(
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _property(context, snapshot.data.documents[index]),
            );
          }),
    );
  }
}
