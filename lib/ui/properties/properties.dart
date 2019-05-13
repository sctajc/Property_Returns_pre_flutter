import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_returns/UI/properties/property_details.dart';
import 'package:property_returns/UI/properties/unit_details.dart';
import 'package:property_returns/ui/properties/property_information.dart';
import 'package:property_returns/util/my_icons_icons.dart';

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
                          builder: (context) => PropertyDetails(
                                document['propertyname'],
                                document['propertyaddress'],
                                document['propertynotes'],
                                document['propertyzone'],
                                document['propertyLegalDescription'],
                                document['propertyDatePurchased'],
                                document['propertyLandArea'],
                                document['propertyInsurancePolicy'],
                                document['propertyInsuranceAmount'],
                                document['propertyInsuranceDate'],
                                document['propertyInsuranceSource'],
                                document['propertyMarketValuation'],
                                document['propertyMarketValuationDate'],
                                document['propertyMarketValuationSource'],
                                document.documentID,
                              ),
                        ),
                      );
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
                          if (snapshot.data.documents.length == 0)
                            return Column(
                              children: <Widget>[
                                Text(
                                  'No units have been assigned.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blueAccent[200],
                                  ),
                                ),
                                Text(
                                  'A unit is a defined area within a property available for renting.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
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
        maxLines: 1,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Properties'), actions: <Widget>[
        IconButton(
            icon: Icon(MyIcons.assessment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PropertyInformation(),
                ),
              );
            })
      ]),
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
                  builder: (context) => PropertyDetails(
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                      ),
                ),
              );
            }),
      ],
    );
  }
}
