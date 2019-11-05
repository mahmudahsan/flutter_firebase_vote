/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import 'package:flutter/material.dart';
import 'package:flutter_firebase_vote/widgets/shared_widgets.dart';
import 'package:flutter_firebase_vote/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_vote/state/authentication.dart';
import 'package:flutter_firebase_vote/utilities.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gotoHomeScreen(context);

    return Consumer<AuthenticationState>(
      builder: (builder, authState, child) {
        return Container(
          width: 400,
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  kAppName,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 200.0,
              ),
              if (authState.authStatus == kAuthLoading)
                Text(
                  'loading...',
                  style: TextStyle(fontSize: 12.0),
                ),
              if (authState.authStatus == null ||
                  authState.authStatus == kAuthError)
                Container(
                  child: Column(
                    children: <Widget>[
                      LoginButton(
                        label: 'Google Sign In',
                        onPressed: () => signIn(context, kAuthSignInGoogle),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LoginButton(
                        label: 'Anonymous Sign In',
                        onPressed: () => signIn(context, kAuthSignInAnonymous),
                      ),
                    ],
                  ),
                ),
              if (authState.authStatus == kAuthError)
                Text(
                  'Error...',
                  style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
                ),
            ],
          ),
        );
      },
    );
  }

  void signIn(context, String service) {
    //Navigator.pushReplacementNamed(context, '/home');
    Provider.of<AuthenticationState>(context, listen: true)
        .login(serviceName: service);
  }
}
