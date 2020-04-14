
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  //sign  in ano

  //sign in with email  & password

  //register with email & pawword

  // sign out

  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    //final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    //final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
//    print("signed in " + user.displayName);
//    return user;
  }

}