import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/launch_screen.dart';
import 'screens/home_screen.dart';
import 'constants.dart';
import 'package:flutter_firebase_vote/state/vote.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => VoteState(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
                body: LaunchScreen(),
              ),
          '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: Text(kAppName),
                ),
                body: HomeScreeen(),
              ),
        },
      ),
    );
  }
}
