import 'package:flutter/material.dart';

class PropertyDetails extends StatefulWidget {
  var propertyId;
  PropertyDetails(this.propertyId);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${widget.propertyId}'),
    );
  }
}
