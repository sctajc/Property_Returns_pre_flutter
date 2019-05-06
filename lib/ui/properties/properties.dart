import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:property_returns/UI/properties/property_details.dart';
import 'package:property_returns/UI/properties/unit_details.dart';

class Properties extends StatelessWidget {
  Widget _property(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          // display property
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PropertyDetails(document['propertyid'])));
            },
            child: Container(
              child: Text(
                document['propertyname'],
                style: Theme.of(context).textTheme.title,
              ),
            ),
          )),
          // display units for a property
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
                        shrinkWrap: true,
                        itemExtent: 20,
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
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UnitDetails(document['unitid'])));
        },
        child: Text(document['unitname']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      // Display all properties
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('properties')
              .orderBy('propertyname')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading');
            return ListView.builder(
              shrinkWrap: true,
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _property(context, snapshot.data.documents[index]),
            );
          }),
      // add floating button
      persistentFooterButtons: <Widget>[
        RaisedButton(
            child: Text(
              'Add a Property',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PropertyDetails('newproperty')));
            }),
        RaisedButton(
            child: Text(
              'Add a Unit',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: null)
      ],
    );
  }
}
