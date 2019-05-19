import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_returns/UI/properties/property_details.dart';
import 'package:property_returns/UI/properties/unit_details.dart';
import 'package:property_returns/ui/properties/property_information.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Properties extends StatelessWidget {
//  var uid = FirebaseAuth.instance.currentUser();
  String propertyID;
  String propertyName;

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
              .orderBy('propertyName')
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

      // to add a new property
      persistentFooterButtons: <Widget>[
        RaisedButton(
            child: Text(
              'Add a new Property',
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

  // to display each existing property, 'Add a Unit' button & all the property units
  Widget _property(BuildContext context, DocumentSnapshot document) {
    propertyID = document.documentID;
    propertyName = document['propertyName'];

    print('At _property: propertyID = $propertyID');
    print('At _property: propertyName = $propertyName');

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
                  // to display property name & edit
                  GestureDetector(
                    child: Text(document['propertyName'],
                        style: TextStyle(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight
                                .w500) //Theme.of(context).textTheme.title,
                        ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetails(
                                document['propertyName'],
                                document['propertyAddress'],
                                document['propertyNotes'],
                                document['propertyZone'],
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
                  ),

                  // to add a new unit
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnitDetails(
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                document.documentID, //propertyID,
                                document['propertyName'], //propertyName,
                              ),
                        ),
                      );
                    },
                    child: Text('Add a Unit'),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),

              // display & edit existing units for a property
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[100])),
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('units')
                            .where('propertyID', isEqualTo: propertyID)
                            .where('unitArchived', isEqualTo: 'n')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const Text('Loading');
                          // if property has no units
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
//                                Text(
//                                  'A unit is a defined area within a property available for renting.',
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    fontWeight: FontWeight.w300,
//                                    color: Colors.black,
//                                  ),
//                                ),
                              ],
                            );
                          // display all units for a property
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scrollbar(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemExtent: 20,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) => _units(
                                      context, snapshot.data.documents[index])),
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

  // display property units with link to edit an existing unit
  Widget _units(BuildContext context, DocumentSnapshot document) {
    return GestureDetector(
      child: Text(
        document['unitName'],
        maxLines: 1,
        style: TextStyle(fontSize: 15),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnitDetails(
                  document['unitName'],
                  document['unitArea'],
                  document['unitNotes'],
                  document['unitResidential'],
                  document['unitLeaseDescription'],
                  document.documentID, // unit's UID
                  document['propertyID'], //propertyID,
                  '', //propertyName, if I could work out how to pass it!!
                  // currently only passing the last property displayed
                ),
          ),
        );
      },
    );
  }
}
