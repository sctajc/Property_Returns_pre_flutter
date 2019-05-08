import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_returns/UI/properties/property_details.dart';
import 'package:property_returns/UI/properties/unit_details.dart';

class Properties extends StatelessWidget {
  Widget _property(BuildContext context, DocumentSnapshot document) {
    return Scrollbar(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // display property
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PropertyDetails(document['propertyid'])));
                    },
                    child: Text(document['propertyname'],
                        style: TextStyle(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight
                                .w500) //Theme.of(context).textTheme.title,
                        ),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text('Add a Unit'),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),

              // display units for a property
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[100])),
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('units')
                            .where('propertyid',
                                isEqualTo: document['propertyid'])
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const Text('Loading');
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scrollbar(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemExtent: 20,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => _units(
                                    context, snapshot.data.documents[index]),
                              ),
                            ),
                          );
                        })),
              )
            ],
          ),
        ),
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
      child: Text(
        document['unitname'],
        style: TextStyle(fontSize: 15),
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
          stream: Firestore.instance
              .collection('properties')
              .orderBy('propertyname')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading');
            return ListView.builder(
              itemExtent: 120,
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
      ],
    );
  }
}
