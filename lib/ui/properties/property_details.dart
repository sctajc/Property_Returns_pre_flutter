import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:property_returns/UI/properties/property_db.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:property_returns/UI/properties/properties.dart';

class PropertyDetails extends StatefulWidget {
  final String propertyId;

  PropertyDetails(this.propertyId);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  String propertyName = 'jjjj';

  sendToServer() {
//    save property data
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          Firestore.instance.collection('properties');
      await reference.add({"Title": "$propertyName", "Author": "author"});
    });
    // navigate back to properties
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Properties()));
  }

  Widget _propertyDetails(BuildContext context, DocumentSnapshot document) {
//    print('I am here');
//    print(document[propertyname]);
    String _validateName(String value) {
      if (value.isEmpty) return 'Property name is required';
      return null;
    }

//    if(document['propertyname'] == null ) document['propertyname'] = '';

//    var _propertyNameController;
//    if (document['propertyname']) {
//      var _propertyNameController =
//          TextEditingController(text: document['propertyname']);
//    } else {
//      TextEditingController(text: '');
//    }

    var _propertyNameController =
        TextEditingController(text: document['propertyname']);
    var _propertyAddressController =
        TextEditingController(text: document['propertyaddress']);
    var _propertyNotesController =
        TextEditingController(text: document['propertynotes']);
    var _propertyZoneController =
        TextEditingController(text: document['propertyzone']);
    var _propertyLegalDescriptionController =
        TextEditingController(text: document['propertylegaldescription']);
    var _propertyDatePurchasedController =
        TextEditingController(text: document['propertydatepurchased']);
    var _propertyLandAreaController =
        TextEditingController(text: document['propertylandarea']);
    var _propertyInsurancePolicyController =
        TextEditingController(text: document['propertyinsurancepolicy']);
    var _propertyInsuranceAmountController =
        TextEditingController(text: document['propertyinsuranceamount']);
    var _propertyInsuranceDateController =
        TextEditingController(text: document['propertyinsurancedate']);
    var _propertyInsuranceSourceController =
        TextEditingController(text: document['propertyinsurancesource']);
    var _propertyMarketValuationController =
        TextEditingController(text: document['propertymarketvaluation']);
    var _propertyMarketValuationDateController =
        TextEditingController(text: document['propertymarketvaluationdate']);
    var _propertyMarketValuationSourceController =
        TextEditingController(text: document['propertymarketvaluationsource']);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 24),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                labelText: 'Property Name',
                hintText: 'A convient name eg Jones St corner',
              ),
              controller: _propertyNameController,
              validator: _validateName,
              onSaved: (String val) {
                propertyName = 'onSaved property Name'; //val;
                print('Saving Property Name: $propertyName');
              },
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                labelText: 'Property Address',
                hintText: 'eg 123 Smart Rd',
                suffixIcon: Icon(Icons.my_location),
              ),
              controller: _propertyAddressController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Property Zone',
                  hintText: 'Light Industrial'),
              controller: _propertyZoneController,
            ),
            SizedBox(height: 24),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Property Notes',
                  hintText: 'Whatever',
                  helperText: 'Keep short'),
              controller: _propertyNotesController,
            ),
            SizedBox(height: 24),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  suffixIcon: Icon(Icons.photo_album),
                  labelText: 'Land Area',
                  hintText: 'Land area. Not building area',
                  helperText: 'm2',
                  prefixText: 'm2: '),
              controller: _propertyLandAreaController,
            ),
            SizedBox(height: 24),
            TextFormField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Date Purchased'),
              controller: _propertyDatePurchasedController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'property Legal Description',
                  hintText: 'Whatever you call it'),
              controller: _propertyLegalDescriptionController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Insurance Policy',
                  hintText: 'Insurance company/policy number'),
              controller: _propertyInsurancePolicyController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Date of Insurance'),
              controller: _propertyInsuranceDateController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Insurance Amount',
                  hintText: 'Whatever you call it'),
              controller: _propertyInsuranceAmountController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Insurance Source'),
              controller: _propertyInsuranceSourceController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Market Valuation'),
              controller: _propertyMarketValuationController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Valuation Date'),
              controller: _propertyMarketValuationDateController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  labelText: 'Valuation Source'),
              controller: _propertyMarketValuationSourceController,
            ),
            SizedBox(height: 24),
            Row(
              children: <Widget>[
                Padding(
                  child: Text(
                    "Property Id ${document['propertyid']}  --  ",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Padding(
                  child: Text(
                    "Display order ${document['displayorder'].toString()}",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                ),
              ],
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
        actions: <Widget>[
          // Save new property or save changes
          IconButton(icon: Icon(MyIcons.done), onPressed: sendToServer //() {
              )
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('properties')
              .where('propertyid', isEqualTo: '${widget.propertyId}')
              .snapshots(),
          builder: (context, snapshot) {
            if ('${widget.propertyId}' == 'newproperty')
              return ListView.builder(
                shrinkWrap: true,
                itemExtent: null,
                itemBuilder: (context, index) =>
                    _propertyDetails(context, null),
              );

            if (!snapshot.hasData) return const Text('Loading');

            return ListView.builder(
              shrinkWrap: true,
              itemExtent: null,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _propertyDetails(context, snapshot.data.documents[index]),
            );
          }),
    );
  }
}

//_sendToServer(){
//  if (_key.currentState.validate() ){
//    //No error in validator
//    _key.currentState.save();
//    Firestore.instance.runTransaction((Transaction transaction) async {
//      CollectionReference reference = Firestore.instance.collection('books');
//
//      await reference.add({"Title": "$title", "Author": "$author"});
//    });
//  } else {
//    // validation error
//    setState(() {
//      _validate = true;
//    });
//  }
//
//}
