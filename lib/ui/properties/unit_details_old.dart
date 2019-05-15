import 'package:flutter/material.dart';
import 'package:property_returns/ui/properties/property_information.dart';
import 'package:property_returns/util/my_icons_icons.dart';

class UnitDetails extends StatefulWidget {
  final String unitId;
  UnitDetails(this.unitId);

  @override
  _UnitDetailsState createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: Center(child: Text('${widget.unitId}')),
      ),
    );
  }
}
