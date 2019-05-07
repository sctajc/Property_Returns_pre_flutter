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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Returns',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  String displayName;
  String email;
  String uid;

  @override
  Widget build(BuildContext context) {
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
    authService.user.toString();

    print('_profile in build = $_profile');

    displayName = _profile == null
        ? 'Not Signed In'
        : '${_profile['displayName'].toString()}';
    if (displayName.length < 1) displayName = 'Not Signed In';

    email = _profile['email'].toString();
    uid = _profile['uid'].toString();

    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 0, top: 0),
      accountName: Text(displayName == null
          ? 'You are not logged in and not required.'
          : '$displayName'),
      accountEmail: Text(
          email == null ? 'Login to use your Google Contacts etc' : '$email'),
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
          title: Text(_profile['uid'] == null ? 'Log in' : 'Log out'),
          onTap: () {
            if (_profile['uid'] == null) {
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
      appBar: AppBar(),
      body: Center(child: HomePage()),
      drawer: Drawer(child: drawerItems),
    );
  }
}
