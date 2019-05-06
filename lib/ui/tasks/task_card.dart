import 'package:flutter/material.dart';
import 'package:property_returns/UI/tasks/task_details.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final receivedDateTime;
  final int importance;
  final String detail;
  final String documentID;

  TaskCard(
      {@required this.title,
      this.receivedDateTime,
      this.importance,
      this.detail,
      this.documentID});

  @override
  Widget build(BuildContext context) {
    var dueDateTime =
        (receivedDateTime != null) ? receivedDateTime.toDate() : null;
    String displayDate = (dueDateTime is DateTime)
        ? DateFormat("EEEE, MMMM d, yyyy 'at' h:mma").format(dueDateTime)
        : 'no due date';

    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$title',
                    style: TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '$displayDate',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetail(
                          title,
                          dueDateTime,
                          importance,
                          detail,
                          documentID,
                        ),
                  ),
                );
              },
              child: Text('Details'))
        ],
      ),
    );
  }
}
