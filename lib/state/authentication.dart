/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import "package:flutter/material.dart";
import "package:flutter_firebase_vote/services/authentication.dart";
import '../services/constants.dart';

const String kAuthError = 'error';
const String kAuthSuccess = 'success';
const String kAuthLoading = 'loading';
const String kAuthSignInGoogle = 'google';
const String kAuthSignInAnonymous = 'anonymous';

class AuthenticationState with ChangeNotifier {
  String _authStatus;
  String _username;
  String _uid;

  String get authStatus => _authStatus;
  String get username => _username;
  String get uid => _uid;

  AuthenticationState() {
    clearState();
    // checkAuthentication();

    onAuthenticationChange((user) {
      if (user != null) {
        _authStatus = kAuthSuccess;
        _username = user[kUsername];
        _uid = user[kUID];
      } else {
        clearState();
      }

      notifyListeners();
    });
  }

  void checkAuthentication() async {
    _authStatus = kAuthLoading;

    if (await isUserSignedIn()) {
      _authStatus = kAuthSuccess;
    } else {
      _authStatus = kAuthError;
    }

    Map<String, String> user = await getCurrentUser();
    _username = user != null ? user[kUsername] : '';
    _uid = user != null ? user[kUID] : '';

    notifyListeners();
  }

  void clearState() {
    _authStatus = null;
    _username = null;
    _uid = null;
  }

  void login({String serviceName}) {
    if (serviceName == kAuthSignInGoogle) {
      signInWithGoogle();
    } else if (serviceName == kAuthSignInAnonymous) {
      signInAnonymously();
    }
  }

  void logout() {
    clearState();
    signOut();
  }
}
