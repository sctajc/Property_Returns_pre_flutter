import 'package:flutter/material.dart';
import 'UI/events.dart';
import 'UI/to_do.dart';
import 'UI/properties.dart';
import 'package:flutter/rendering.dart';
import 'util/auth.dart';
import 'package:property_returns/util/user.dart';

String _uid = '1234';
String _userName = 'Stephen Thoms';
String _userEmail = 'stephen@propertyreturns.co.nz';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Property Returns';
  final User value;

  MyApp({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    if (_uid == null) {
      _userName = "Please Log In";
      _userEmail = "";
    }

    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 0, top: 0),
      accountName: Text('$_userName'),
      accountEmail: Text('$_userEmail'),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(
          size: 32,
        ),
        backgroundColor: Colors.white,
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Text('A'),
          backgroundColor: Colors.cyan,
        ),
        CircleAvatar(
          child: Text('B'),
          backgroundColor: Colors.amber,
        )
      ],
    );

    final drawerItems = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('To do'),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => ToDo())),
        ),
        ListTile(
          title: Text('Lease events'),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Events())),
        ),
        Divider(
          height: 0,
          indent: 15,
          color: Colors.blueAccent,
        ),
        ListTile(
          title: Text('Your properties'),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Properties())),
        ),
        ListTile(
          title: Text('Tenants'),
          onTap: () => null,
        ),
        ListTile(
          title: Text('Trades'),
          onTap: () => null,
        ),
        ListTile(
          title: Text('Agents'),
          onTap: () => null,
        ),
        ListTile(
          title: Text('Documents'),
          onTap: () => null,
        ),
        Divider(
          height: 0,
          indent: 15,
          color: Colors.blueAccent,
        ),
        ListTile(
//            widget?.value?.uid ?? false
          title: Text(_uid == null ? 'Log in' : 'Log out'),
          onTap: () {
            if (_uid == null) {
              // Log in
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginButton()));
            } else {
              // Log out
              authService.signOut();
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (BuildContext context) => LoginButton()));
            }
          },
//            onTap: () => Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (BuildContext context) => LoginButton()))
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () => null,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(child: drawerItems),
    );
  }
}
