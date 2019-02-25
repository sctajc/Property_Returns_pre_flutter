import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Properties extends StatelessWidget {
  Widget _property(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            document['propertyname'],
            style: Theme.of(context).textTheme.title,
          )),
          Expanded(
            child: Container(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('units')
                        .where('propertyid', isEqualTo: document['propertyid'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text('Loading');
                      return ListView.builder(
                        itemExtent: 15,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) =>
                            _units(context, snapshot.data.documents[index]),
                      );
                    })),
          )
        ],
      ),
    );
  }

  Widget _units(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            document['unitname'],
            style: Theme.of(context).textTheme.body1,
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
