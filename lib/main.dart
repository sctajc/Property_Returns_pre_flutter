import 'package:flutter/material.dart';
import 'UI/events.dart';
import 'UI/to_do.dart';
import 'UI/properties.dart';
import 'package:flutter/rendering.dart';
import 'util/auth.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Property Returns';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 0, top: 0),
      accountName: Text('User Name'),
      accountEmail: Text('User Email'),
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
          title: Text('Log In'),
//          onTap: () => null,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginButton())),
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () => null,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(child: drawerItems),
    );
  }
}
