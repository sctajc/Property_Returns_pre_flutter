import 'package:flutter/material.dart';
import 'package:property_returns/UI/lease_events/events.dart';
import 'package:property_returns/ui/tasks/tasks.dart';
import 'package:property_returns/UI/properties/properties.dart';
import 'package:flutter/rendering.dart';
import 'util/auth.dart';
import 'package:property_returns/util/user.dart';
import 'package:property_returns/home_page.dart';

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
    if (value == null) {
      print('MyApp - value.hascode is null ie user is not signed in');
    } else {
      print(
          'MyApp- -value.hascode is not null ie user is signed in ${value.uid}');
    }
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle, value: value),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final User value;

  MyHomePage({Key key, this.title, this.value}) : super(key: key);

  @override
  MyHomePageState createState() {
    if (value == null) {
      print('MyHomePage - value.hascode is null ie user is not signed in');
    } else {
      print(
          'MyHomePage - value.hascode is not null ie user is signed in ${value.uid} ${value.username} ${value.email}');
    }
    return new MyHomePageState(value: value);
  }
}

class MyHomePageState extends State<MyHomePage> {
  final User value;

  MyHomePageState({this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      print('MyHomePageState - value.hascode is null ie user is not signed in');
    } else {
      print(
          'MyHomePageState - value.hascode is not null ie user is signed in uid = $value ${value.uid} ${value.username} ${value.email}');
    }

    String uid;
    if (value != null) {
      uid = '${value.uid}';
    }

    String _userName;
    if (value != null) {
      _userName = '${value.username}';
    }

    String _userEmail;
    if (value != null) {
      _userEmail = '${value.email}';
    }

//    String _uid = (value == null) ? null : '${value.uid}';
//    print('_uid = $_uid');
//    String _userName = (value == null) ? null : '${value.username}';
//    String _userEmail = (value == null) ? null : '${value.email}';

    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 0, top: 0),
      accountName: Text(uid == null
          ? 'You are not logged in and not required.'
          : 'Preturns'), //'$_userName'),
      accountEmail: Text(uid == null
          ? 'Login to use your Google Contacts etc'
          : 'preturns99@gmail.com'), // '$_userEmail'),
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
          title: Text('Tasks'),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Tasks())),
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
          title: Text(uid == null ? 'Log in' : 'Log out'),
          onTap: () {
            if (uid == null) {
              // Log in
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginButton()));
            } else {
              // Log out
              authService.signOut();
            }
          },
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () => null,
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: HomePage()),
      drawer: Drawer(child: drawerItems),
    );
  }
}
