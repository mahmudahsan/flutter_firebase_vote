/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<bool> isUserSignedIn() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  return currentUser != null;
}

void signOut() {
  try {
    _auth.signOut();
  } catch (error) {
    print(error);
  }
}

void onAuthenticationChange(Function isLogin) {
  _auth.onAuthStateChanged.listen((FirebaseUser user) {
    if (user != null) {
      isLogin(true);
    } else {
      isLogin(false);
    }
  });
}

Future<Map<String, String>> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

  if (user != null) {
    return {'username': user.displayName, 'uid': user.uid};
  }
  return null;
}

Future<Map<String, String>> signInAnonymously() async {
  final FirebaseUser user = (await _auth.signInAnonymously()).user;

  if (user != null) {
    return {'username': '', 'uid': user.uid};
  }
  return null;
}
