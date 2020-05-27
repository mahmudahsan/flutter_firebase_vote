/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import "package:flutter/material.dart";
import 'package:flutter_firebase_vote/services/services.dart';
import 'package:flutter_firebase_vote/state/vote.dart';
import "package:provider/provider.dart";
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import "../widgets/vote_list.dart";
import "../widgets/vote.dart";
import "../state/vote.dart";

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    // loading votes
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<VoteState>(builder: (builder, voteState, child) {
              return Container(
                child: Column(
                  children: <Widget>[
                    if (voteState.voteList == null)
                      Container(
                        color: Colors.lightBlue,
                        child: Center(
                          child: Loading(
                              indicator: BallPulseIndicator(), size: 100.0),
                        ),
                      ),
                    if (voteState.voteList != null)
                      Expanded(
                        child: Stepper(
                          type: StepperType.horizontal,
                          currentStep: _currentStep,
                          steps: [
                            getStep(
                              title: 'Choose',
                              child: VoteListWidget(),
                              isActive: true,
                            ),
                            getStep(
                              title: 'Vote',
                              child: VoteWidget(),
                              isActive: _currentStep >= 1 ? true : false,
                            ),
                          ],
                          onStepCancel: () {
                            if (_currentStep <= 0) {
                              voteState.activeVote = null;
                            } else if (_currentStep <= 1) {
                              voteState.selectedOptionInActiveVote = null;
                            }

                            setState(() {
                              _currentStep =
                                  (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
                            });
                          },
                          onStepContinue: () {
                            if (_currentStep == 0) {
                              if (step2Required(voteState)) {
                                setState(() {
                                  _currentStep = (_currentStep + 1) > 2
                                      ? 2
                                      : _currentStep + 1;
                                });
                              } else {
                                showSnackBar(
                                    context, 'Please select a vote first!');
                              }
                            } else if (_currentStep == 1) {
                              if (step3Required(voteState)) {
                                // submit vote
                                markMyVote(voteState);

                                // Go To Result Screen
                                Navigator.pushReplacementNamed(
                                    context, '/result');
                              } else {
                                showSnackBar(context, 'Please mark your vote!');
                              }
                            }
                          },
                        ),
                      ),
                  ],
                ),
              );
            })),
      ),
    );
  }

  bool step2Required(VoteState voteState) {
    if (voteState.activeVote == null) {
      return false;
    }

    return true;
  }

  bool step3Required(VoteState voteState) {
    if (voteState.selectedOptionInActiveVote == null) {
      return false;
    }
    return true;
  }

  void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 22),
      ),
    ));
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

  void markMyVote(VoteState voteState) {
    final voteId = voteState.activeVote.voteId;
    final option = voteState.selectedOptionInActiveVote;

    markVote(voteId, option);
  }
}
