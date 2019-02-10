import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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
    // start
    loading.add(true);

    // Step 1 - Login with Google. This shows Google’s native login screen and provides the idToken and accessToken.
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Step 2 - Login to Firebase. At this point, the user is logged into Google, but not Firebase. We can simply pass the tokens to Firebase to login.
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    // Step 3 - Update Firestore. At this point, we can update the database with any custom data we want to use in the UI.
    updateUserData(user);

    // Done
    loading.add(false);
    print("signed in " + user.displayName);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.displayName,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
    });
  }

  void signOut() {
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
