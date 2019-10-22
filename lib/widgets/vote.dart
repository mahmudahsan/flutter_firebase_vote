/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_firebase_vote/models/vote.dart";
import "package:flutter_firebase_vote/state/vote.dart";

class VoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Vote activeVote = Provider.of<VoteState>(context).activeVote;
    List<String> options = List<String>();

    for (Map<String, int> option in activeVote.options)
      option.forEach((title, value) {
        options.add(title);
      });

    return Column(
      children: <Widget>[
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Text(
              activeVote.voteTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
        ),
        for (String option in options)
          Card(
            child: InkWell(
              onTap: () {
                Provider.of<VoteState>(context).selectedOptionInActiveVote =
                    option;
              },
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(minHeight: 60),
                      width: 8,
                      color: Colors.green,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          option,
                          maxLines: 5,
                          style: TextStyle(fontSize: 22),
                        ),
                        color: Provider.of<VoteState>(context)
                                    .selectedOptionInActiveVote ==
                                option
                            ? Colors.green
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
