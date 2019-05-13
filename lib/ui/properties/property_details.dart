// property_details bases on task_details

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_returns/UI/properties/property_db.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:property_returns/UI/properties/properties.dart';
import 'package:property_returns/ui/properties/property_information.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:property_returns/util/auth.dart';

class PropertyDetails extends StatefulWidget {
  final String propertyName;
  final String propertyAddress;
  final String propertyNotes;
  final String propertyZone;
  final String propertyLegalDescription;
  final String propertyDatePurchased;
  final String propertyLandArea;
  final String propertyInsurancePolicy;
  final String propertyInsuranceAmount;
  final String propertyInsuranceDate;
  final String propertyInsuranceSource;
  final String propertyMarketValuation;
  final String propertyMarketValuationDate;
  final String propertyMarketValuationSource;
  final String documentID;

  PropertyDetails(
    this.propertyName,
    this.propertyAddress,
    this.propertyNotes,
    this.propertyZone,
    this.propertyLegalDescription,
    this.propertyDatePurchased,
    this.propertyLandArea,
    this.propertyInsurancePolicy,
    this.propertyInsuranceAmount,
    this.propertyInsuranceDate,
    this.propertyInsuranceSource,
    this.propertyMarketValuation,
    this.propertyMarketValuationDate,
    this.propertyMarketValuationSource,
    this.documentID,
  );

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  Map<String, dynamic> _profile;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _propertyAddressController =
      TextEditingController();
  final TextEditingController _propertyNotesController =
      TextEditingController();
  final TextEditingController _propertyZoneController = TextEditingController();
  final TextEditingController _propertyLegalDescriptionController =
      TextEditingController();
  final TextEditingController _propertyDatePurchasedController =
      TextEditingController();
  final TextEditingController _propertyLandAreaController =
      TextEditingController();
  final TextEditingController _propertyInsurancePolicyController =
      TextEditingController();
  final TextEditingController _propertyInsuranceAmountController =
      TextEditingController();
  final TextEditingController _propertyInsuranceDateController =
      TextEditingController();
  final TextEditingController _propertyInsuranceSourceController =
      TextEditingController();
  final TextEditingController _propertyMarketValuationController =
      TextEditingController();
  final TextEditingController _propertyMarketValuationDateController =
      TextEditingController();
  final TextEditingController _propertyMarketValuationSourceController =
      TextEditingController();

  bool _isDeleteButtonDisabled;
  bool _isArchiveButtonDisabled;

  @override
  void initState() {
    super.initState();
    _propertyNameController.text = widget.propertyName;
    _propertyAddressController.text = widget.propertyAddress;
    _propertyNotesController.text = widget.propertyNotes;
    _propertyZoneController.text = widget.propertyZone;
    _propertyLegalDescriptionController.text = widget.propertyLegalDescription;
    _propertyDatePurchasedController.text = widget.propertyDatePurchased;
    _propertyLandAreaController.text = widget.propertyLandArea;
    _propertyInsurancePolicyController.text = widget.propertyInsurancePolicy;
    _propertyInsuranceAmountController.text = widget.propertyInsuranceAmount;
    _propertyInsuranceDateController.text = widget.propertyInsuranceDate;
    _propertyInsuranceSourceController.text = widget.propertyInsuranceSource;
    _propertyMarketValuationController.text = widget.propertyMarketValuation;
    _propertyMarketValuationDateController.text =
        widget.propertyMarketValuationDate;
    _propertyMarketValuationSourceController.text =
        widget.propertyMarketValuationSource;

    _isDeleteButtonDisabled = widget.documentID.isEmpty ? true : false;
    _isArchiveButtonDisabled = widget.documentID.isEmpty ? true : false;
  }

  @override
  void dispose() {
    _propertyNameController.dispose();
    _propertyAddressController.dispose();
    _propertyNotesController.dispose();
    _propertyZoneController.dispose();
    _propertyLegalDescriptionController.dispose();
    _propertyDatePurchasedController.dispose();
    _propertyLandAreaController.dispose();
    _propertyInsurancePolicyController.dispose();
    _propertyInsuranceAmountController.dispose();
    _propertyInsuranceDateController.dispose();
    _propertyInsuranceSourceController.dispose();
    _propertyMarketValuationController.dispose();
    _propertyMarketValuationDateController.dispose();
    _propertyMarketValuationSourceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authService.profile.listen((state) => setState(() => _profile = state));
//    authService.loading.listen((state) => setState(() => _loading = state));
    authService.user.toString();

    // toDo get user _uid from profile. Not this!!
    String _uid = '1111111111111111'; //_profile['uid'];

    String buttonSaveUpdateText =
        widget.propertyName == '' ? 'Create' : 'Update';

    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
        actions: <Widget>[
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
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _propertyNameController,
                  autofocus: widget.documentID.isEmpty ? true : false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'A common name for this property',
                      labelText: 'Property Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a property name';
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _propertyAddressController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'The property street address',
                      labelText: 'Property Address'),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter a property Address';
//                    }
//                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _propertyNotesController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'property notes',
                      labelText: 'Property Notes'),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter a property Notes';
//                    }
//                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _propertyZoneController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'property zone',
                      labelText: 'Property Zone'),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter a property Notes';
//                    }
//                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _propertyLegalDescriptionController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'legal description',
                      labelText: 'Legal Description'),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter a property Notes';
//                    }
//                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _propertyDatePurchasedController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'date purchased',
                      labelText: 'Date Purchased'),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter a property Notes';
//                    }
//                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _propertyLandAreaController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'land area',
                      labelText: 'Land Area'),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter a property Notes';
//                    }
//                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (_propertyNameController.text.isNotEmpty) {
                            if (widget.documentID.isEmpty) {
                              Firestore.instance
                                  .collection('properties')
                                  .add({
                                    "propertyname":
                                        _propertyNameController.text,
                                    "propertyaddress":
                                        _propertyAddressController.text,
                                    "propertynotes":
                                        _propertyNotesController.text,
                                    "propertyzone":
                                        _propertyZoneController.text,
                                    "propertylegaldescription":
                                        _propertyLegalDescriptionController
                                            .text,
                                    "propertydatepurchased":
                                        _propertyDatePurchasedController.text,
                                    "propertylandarea":
                                        _propertyLandAreaController.text,
                                    "createdDateTime": DateTime.now(),
                                    "archived": 'n',
                                    "uid": _uid,
                                  })
                                  .then((result) => {
                                        Navigator.pop(context),
                                        //toDo complete list below
                                        _propertyNameController.clear(),
                                        _propertyAddressController.clear(),
                                      })
                                  .catchError((err) => print(err));
                            } else {
                              Map<String, dynamic> data = {
                                "propertyname": _propertyNameController.text,
                                "propertyaddress":
                                    _propertyAddressController.text,
                                "propertynotes": _propertyNotesController.text,
                                "propertyzone": _propertyZoneController.text,
                                "propertylegaldescription":
                                    _propertyLegalDescriptionController.text,
                                "propertydatepurchased":
                                    _propertyDatePurchasedController.text,
                                "propertylandarea":
                                    _propertyLandAreaController.text,
                                "editedDatetime": DateTime.now(),
                              };
                              Firestore.instance
                                  .collection('properties')
                                  .document(widget.documentID)
                                  .updateData(data)
                                  .whenComplete(() {
                                    print('Document Updated');
                                  })
                                  .then((result) => {
                                        Navigator.pop(context),
                                        //toDo complete list below
                                        _propertyNameController.clear(),
                                        _propertyAddressController.clear(),
                                      })
                                  .catchError((err) => print(err));
                            }
                          }
                        }
                      },
                      child: Text('$buttonSaveUpdateText'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      disabledColor: Colors.grey[200],
                      onPressed:
                          _isArchiveButtonDisabled ? null : _archiveProperty,
                      child: Text('Archive'),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton(
                      textColor: Colors.red,
                      disabledColor: Colors.red[200],
                      onPressed:
                          _isDeleteButtonDisabled ? null : _deleteProperty,
                      child: Text(
                        'Delete',
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteProperty() {
    Firestore.instance
        .collection('propertiess')
        .document(widget.documentID)
        .delete()
        .whenComplete(() {
          print('Document deleted');
        })
        .then((result) => {
              Navigator.pop(context),
              //ToDo complete the list below
              _propertyNameController.clear(),
              _propertyAddressController.clear(),
            })
        .catchError((err) => print(err));
  }

  void _archiveProperty() {
    Map<String, dynamic> data = {
      "archived": 'y',
    };
    Firestore.instance
        .collection('properties')
        .document(widget.documentID)
        .updateData(data)
        .whenComplete(() {
          print('Document Archived');
        })
        .then((result) => {
              Navigator.pop(context),
              //ToDo complete the list below
              _propertyNameController.clear(),
              _propertyAddressController.clear(),
            })
        .catchError((err) => print(err));
  }
}
