/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import 'package:flutter/material.dart';
import 'package:flutter_firebase_vote/widgets/shared_widgets.dart';
import 'package:flutter_firebase_vote/constants.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          LoginButton(
            label: 'Google Sign In',
            onPressed: () => signIn(context),
          ),
          SizedBox(
            height: 10,
          ),
          LoginButton(
            label: 'Anonymous Sign In',
            onPressed: () => signIn(context),
          ),
        ],
      ),
    );
  }

  void signIn(context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
