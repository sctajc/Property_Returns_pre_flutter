import 'package:flutter/material.dart';

class UnitDetails extends StatefulWidget {
  var unitId;
  UnitDetails(this.unitId);

  @override
  _UnitDetailsState createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${widget.unitId}'),
    );
  }
}
