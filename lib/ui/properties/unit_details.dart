// todo

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_returns/UI/properties/property_db.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:property_returns/UI/properties/properties.dart';
import 'package:property_returns/ui/properties/property_information.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:property_returns/util/auth.dart';

class UnitDetails extends StatefulWidget {
  final String unitName;
  final String unitArea;
  final String unitNotes;
  final String unitResidential;
  final String unitLeaseDescription;
  final String unitID;
  final String propertyID;
  final String propertyName;

  UnitDetails(
    this.unitName,
    this.unitArea,
    this.unitNotes,
    this.unitResidential,
    this.unitLeaseDescription,
    this.unitID,
    this.propertyID,
    this.propertyName,
  );

  @override
  _UnitDetailsState createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  Map<String, dynamic> _profile;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _unitAreaController = TextEditingController();
  final TextEditingController _unitNotesController = TextEditingController();
  final TextEditingController _unitResidentialController =
      TextEditingController();
  final TextEditingController _unitLeaseDescriptionController =
      TextEditingController();

  bool _isDeleteButtonDisabled;
  bool _isArchiveButtonDisabled;

  @override
  void initState() {
    super.initState();
    _unitNameController.text = widget.unitName;
    _unitAreaController.text = widget.unitArea;
    _unitNotesController.text = widget.unitNotes;
    _unitResidentialController.text = widget.unitResidential;
    _unitLeaseDescriptionController.text = widget.unitLeaseDescription;

    _isDeleteButtonDisabled = widget.unitID.isEmpty ? true : false;
    _isArchiveButtonDisabled = widget.unitID.isEmpty ? true : false;
  }

  @override
  void dispose() {
    _unitNameController.dispose();
    _unitAreaController.dispose();
    _unitNotesController.dispose();
    _unitResidentialController.dispose();
    _unitLeaseDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authService.profile.listen((state) => setState(() => _profile = state));
//    authService.loading.listen((state) => setState(() => _loading = state));
    authService.user.toString();

    // toDo get user _uid from profile. Not this!!
    String userID = '1111111111111111'; //_profile['uid'];

    String buttonSaveUpdateText = widget.unitName == '' ? 'Create' : 'Update';

    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Details'),
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
                Text(
                  '${widget.propertyName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: _unitNameController,
                  autofocus: widget.unitID.isEmpty ? true : false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'what this area is know as',
                      labelText: 'Unit Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a unit name';
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _unitAreaController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'The area of the unit',
                      labelText: 'Unit Area'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _unitNotesController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'unit notes',
                      labelText: 'Unit Notes'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _unitResidentialController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Is this Reesidential or Commercial',
                      labelText: 'Residental'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _unitLeaseDescriptionController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'description used on leasing documents etc',
                      labelText: 'Lease Description'),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (_unitNameController.text.isNotEmpty) {
                            if (widget.unitID.isEmpty) {
                              Firestore.instance
                                  .collection('units')
                                  .add({
                                    "unitName": _unitNameController.text,
                                    "unitArea": _unitAreaController.text,
                                    "unitNotes": _unitNotesController.text,
                                    "unitResidential":
                                        _unitResidentialController.text,
                                    "unitLeaseDescription":
                                        _unitLeaseDescriptionController.text,
                                    "propertyID": widget.propertyID,
                                    "unitCreatedDateTime": DateTime.now(),
                                    "unitArchived": 'n',
                                    "uid": userID,
                                  })
                                  .then((result) => {
                                        Navigator.pop(context),
                                        _unitNameController.clear(),
                                        _unitAreaController.clear(),
                                        _unitNotesController.clear(),
                                        _unitResidentialController.clear(),
                                        _unitLeaseDescriptionController.clear(),
                                      })
                                  .catchError((err) => print(err));
                            } else {
                              Map<String, dynamic> data = {
                                "unitName": _unitNameController.text,
                                "unitArea": _unitAreaController.text,
                                "unitNotes": _unitNotesController.text,
                                "unitResidential":
                                    _unitResidentialController.text,
                                "unitLeaseDescription":
                                    _unitLeaseDescriptionController.text,
                                "unitEditedDatetime": DateTime.now(),
                              };
                              Firestore.instance
                                  .collection('units')
                                  .document(widget.unitID)
                                  .updateData(data)
                                  .whenComplete(() {
                                    print('Document Updated');
                                  })
                                  .then((result) => {
                                        Navigator.pop(context),
                                        _unitNameController.clear(),
                                        _unitAreaController.clear(),
                                        _unitNotesController.clear(),
                                        _unitResidentialController.clear(),
                                        _unitLeaseDescriptionController.clear(),
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
                      onPressed: _isDeleteButtonDisabled ? null : _deleteUnit,
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

  void _deleteUnit() {
    Firestore.instance
        .collection('units')
        .document(widget.unitID)
        .delete()
        .whenComplete(() {
          print('Unit deleted');
        })
        .then((result) => {
              Navigator.pop(context),
              _unitNameController.clear(),
              _unitAreaController.clear(),
              _unitNotesController.clear(),
              _unitResidentialController.clear(),
              _unitLeaseDescriptionController.clear(),
            })
        .catchError((err) => print(err));
  }

  void _archiveProperty() {
    Map<String, dynamic> data = {
      "unitArchived": 'y',
    };
    Firestore.instance
        .collection('units')
        .document(widget.unitID)
        .updateData(data)
        .whenComplete(() {
          print('Unit Archived');
        })
        .then((result) => {
              Navigator.pop(context),
              _unitNameController.clear(),
              _unitAreaController.clear(),
              _unitNotesController.clear(),
              _unitResidentialController.clear(),
              _unitLeaseDescriptionController.clear(),
            })
        .catchError((err) => print(err));
  }
}
