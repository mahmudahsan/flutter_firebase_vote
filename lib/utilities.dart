/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_firebase_vote/state/authentication.dart";

void gotoHomeScreen(BuildContext context, AuthenticationState authState) {
  Future.microtask(() {
    if (authState.authStatus == kAuthSuccess) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  });
}

void gotoLoginScreen(BuildContext context, AuthenticationState authState) {
  Future.microtask(() {
    if (authState.authStatus == null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  });
}
