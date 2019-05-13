import 'package:flutter/material.dart';
import 'package:property_returns/ui/tasks/task_card.dart';
import 'package:property_returns/ui/tasks/task_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_returns/ui/tasks/task_information.dart';
import 'package:property_returns/util/my_icons_icons.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('tasks')
                .where('archived', isEqualTo: 'n')
                .orderBy('importance', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents.map(
                      (DocumentSnapshot document) {
                        return new TaskCard(
                          title: document['title'],
                          receivedDateTime: document['dueDateTime'],
                          importance: document['importance'],
                          detail: document['detail'],
                          documentID: document.documentID,
                        );
                      },
                    ).toList(),
                  );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetail(
                  '', DateTime.now().add(Duration(days: 30)), 3, '', ''),
            ),
          );
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
