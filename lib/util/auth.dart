import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'package:property_returns/main.dart' as homepage;
import 'package:property_returns/util/user.dart';

String userName;
String userEmail;
String userUid;

class AuthService {
  // Dependencies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  // Shared State for Widgets
  Observable<FirebaseUser> user; // Firebase user
  Observable<Map<String, dynamic>> profile; // custom user in Firestore
  PublishSubject loading = PublishSubject();

// constructor
  AuthService() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> googleSignIn() async {
    try {
      loading.add(true);
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser user = await _auth.signInWithCredential(credential);

      updateUserData(user);
      print("signed in " + user.displayName);
      loading.add(false);
      return user;
    } catch (error) {
      return error;
    }
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
    });
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'SignOut';
    } catch (e) {
      return e.toString();
    }
  }
}

final AuthService authService = AuthService();

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In using your Google account'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StreamBuilder(
                  stream: authService.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () => authService.signOut(),
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('Sign Out'),
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Text('You are signed in as $userName'),
                                Text('$userEmail'),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return MaterialButton(
                        onPressed: () {
                          authService.googleSignIn();
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => homepage.MyApp(
                                    value: User(
                                  uid: userUid,
                                  username: userName,
                                  email: userEmail,
                                )),
                          );
                          Navigator.of(context).push(route);
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        child: Text('Login with Google'),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
