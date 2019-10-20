/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import "package:flutter/material.dart";
import 'package:flutter_firebase_vote/state/vote.dart';
import "package:provider/provider.dart";
import "../widgets/vote_list.dart";
import "../widgets/vote.dart" as VoteWidget;
import "../models/vote.dart";
import "../state/vote.dart";

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              steps: [
                getStep(
                  title: 'Choose',
                  child: VoteList(),
                  isActive: true,
                ),
                getStep(
                  title: 'Vote',
                  child: VoteWidget.Vote(),
                  isActive: _currentStep >= 1 ? true : false,
                ),
                getStep(
                  title: 'Result',
                  child: Text('hi'),
                  isActive: _currentStep >= 2 ? true : false,
                ),
              ],
              onStepCancel: () {
                setState(() {
                  _currentStep = (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
                });
              },
              onStepContinue: () {
                if (_currentStep >= 0 && step2Required()) {
                  setState(() {
                    _currentStep =
                        (_currentStep + 1) > 2 ? 2 : _currentStep + 1;
                  });
                }
              },
              onStepTapped: (int value) {
                if (step2Required()) {
                  setState(() {
                    _currentStep = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool step2Required() {
    if (Provider.of<VoteState>(context).activeVote == null) {
      return false;
    }

    return true;
  }

  Step getStep({
    String title,
    Widget child,
    bool isActive = false,
  }) {
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }

  Column getOptions({Vote vote}) {
    return Column(
      children: <Widget>[
        for (var option in vote.options)
          ListTile(
            title: Text(option.keys.first),
            leading: Radio(
              value: option.values.first,
              groupValue: vote.voteId,
            ),
          ),
      ],
    );
  }
}
