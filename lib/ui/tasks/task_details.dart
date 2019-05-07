import 'package:flutter/material.dart';
import 'package:property_returns/util/my_icons_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:property_returns/UI/tasks/task_information.dart';
import 'package:property_returns/util/auth.dart';

class TaskDetail extends StatefulWidget {
  final String title;
  final DateTime dueDateTime;
  final int importance;
  final String detail;
  final String documentID;

  TaskDetail(this.title, this.dueDateTime, this.importance, this.detail,
      this.documentID);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  Map<String, dynamic> _profile;

  final _formKey = GlobalKey<FormState>();
  var taskImportance = [
    'Very Important',
    'Important',
    'Must be done',
    'Needs to be done',
    'Do sometime'
  ];

  DateTime _dueDateTime;
  String _currentImportanceSelected;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDetailController = TextEditingController();

  bool _isDeleteButtonDisabled;
  bool _isArchiveButtonDisabled;

  @override
  void initState() {
    super.initState();
    _taskTitleController.text = widget.title;
    _taskDetailController.text = widget.detail;
    _dueDateTime = widget.dueDateTime;
    _currentImportanceSelected = _getImportanceLable(widget.importance);
    _isDeleteButtonDisabled = widget.documentID.isEmpty ? true : false;
    _isArchiveButtonDisabled = widget.documentID.isEmpty ? true : false;
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authService.profile.listen((state) => setState(() => _profile = state));
//    authService.loading.listen((state) => setState(() => _loading = state));
    authService.user.toString();

    String _uid = '1111111111111111'; //_profile['uid'];

    String buttonSaveUpdateText = widget.title == '' ? 'Create' : 'Update';

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: <Widget>[
          IconButton(
              icon: Icon(MyIcons.assessment),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskInformation(),
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
                  controller: _taskTitleController,
                  autofocus: widget.documentID.isEmpty ? true : false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'what is this task',
                      labelText: 'Task Title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Task Title';
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                DateTimePickerFormField(
                  initialValue: _dueDateTime,
                  inputType: InputType.both,
                  format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                  editable: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 5,
                        ),
                      ),
                      labelText: 'Date & Time',
                      hasFloatingPlaceholder: false),
                  onChanged: (dt) => setState(() => _dueDateTime = dt),
                ),
                // dropdown for Task Importance
                Row(
                  children: <Widget>[
                    Text(
                      'Level of Importance',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton<String>(
                      items: taskImportance.map(
                        (String dropdownImportanceItem) {
                          return DropdownMenuItem<String>(
                            value: dropdownImportanceItem,
                            child: Text(dropdownImportanceItem),
                          );
                        },
                      ).toList(),
                      onChanged: (String newTaskSelected) {
                        _onDropDownImportanceSelected(newTaskSelected);
                      },
                      value: _currentImportanceSelected,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  maxLines: 10,
                  controller: _taskDetailController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Enter any details here',
                    labelText: 'Details',
                  ),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (_taskTitleController.text.isNotEmpty) {
                            if (widget.documentID.isEmpty) {
                              Firestore.instance
                                  .collection('tasks')
                                  .add({
                                    "title": _taskTitleController.text,
                                    "dueDateTime": _dueDateTime,
                                    "importance": _getImportanceValue(
                                        _currentImportanceSelected),
                                    "detail": _taskDetailController.text,
                                    "createdDateTime": DateTime.now(),
                                    "archived": 'n',
                                    "uid": _uid,
                                  })
                                  .then((result) => {
                                        Navigator.pop(context),
                                        _taskTitleController.clear(),
                                        _dueDateTime = null,
                                        _currentImportanceSelected = null,
                                        _taskDetailController.clear(),
                                      })
                                  .catchError((err) => print(err));
                            } else {
                              Map<String, dynamic> data = {
                                "title": _taskTitleController.text,
                                "dueDateTime": _dueDateTime,
                                "importance": _getImportanceValue(
                                    _currentImportanceSelected),
                                "detail": _taskDetailController.text,
                                "editedDatetime": DateTime.now(),
                              };
                              Firestore.instance
                                  .collection('tasks')
                                  .document(widget.documentID)
                                  .updateData(data)
                                  .whenComplete(() {
                                    print('Document Updated');
                                  })
                                  .then((result) => {
                                        Navigator.pop(context),
                                        _taskTitleController.clear(),
                                        _dueDateTime = null,
                                        _currentImportanceSelected = null,
                                        _taskDetailController.clear(),
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
                      onPressed: _isArchiveButtonDisabled ? null : _archiveTask,
                      child: Text('Archive'),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton(
                      textColor: Colors.red,
                      disabledColor: Colors.red[200],
                      onPressed: _isDeleteButtonDisabled ? null : _deleteTask,
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

  void _deleteTask() {
    Firestore.instance
        .collection('tasks')
        .document(widget.documentID)
        .delete()
        .whenComplete(() {
          print('Document deleted');
        })
        .then((result) => {
              Navigator.pop(context),
              _taskTitleController.clear(),
              _dueDateTime = null,
              _currentImportanceSelected = null,
              _taskDetailController.clear(),
            })
        .catchError((err) => print(err));
  }

  void _archiveTask() {
    Map<String, dynamic> data = {
      "archived": 'y',
    };
    Firestore.instance
        .collection('tasks')
        .document(widget.documentID)
        .updateData(data)
        .whenComplete(() {
          print('Document Archived');
        })
        .then((result) => {
              Navigator.pop(context),
              _taskTitleController.clear(),
              _dueDateTime = null,
              _currentImportanceSelected = null,
              _taskDetailController.clear(),
            })
        .catchError((err) => print(err));
  }

  int _getImportanceValue(_currentImportanceSelected) {
    int _importance = 3;
    if (_currentImportanceSelected == 'Very Important') _importance = 5;
    if (_currentImportanceSelected == 'Important') _importance = 4;
    if (_currentImportanceSelected == 'Must be done') _importance = 3;
    if (_currentImportanceSelected == 'Needs to be done') _importance = 2;
    if (_currentImportanceSelected == 'Do sometime') _importance = 1;
    return _importance;
  }

  String _getImportanceLable(_importance) {
    String _currentImportanceSelected = 'Must be done';
    if (_importance == 5) _currentImportanceSelected = 'Very Important';
    if (_importance == 4) _currentImportanceSelected = 'Important';
    if (_importance == 3) _currentImportanceSelected = 'Must be done';
    if (_importance == 2) _currentImportanceSelected = 'Needs to be done';
    if (_importance == 1) _currentImportanceSelected = 'Do sometime';
    return _currentImportanceSelected;
  }

  void _onDropDownImportanceSelected(String _newImportanceSelected) {
    setState(
      () {
        this._currentImportanceSelected = _newImportanceSelected;
      },
    );
  }
}
