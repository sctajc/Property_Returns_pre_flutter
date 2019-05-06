import 'package:flutter/material.dart';

class TaskInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Information'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
              'If deleted is gone for good. If archived is kept but not displayed.'
                  ' Total number of archived tasks is not for you to know '
                  'but it has been reported to the KGB'),
        ),
      ),
    );
  }
}
