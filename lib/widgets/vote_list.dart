/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:flutter_firebase_vote/state/vote.dart';
import "package:flutter_firebase_vote/models/vote.dart";

class VoteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function alternateColor = getAlternate(start: 0);
    return Consumer<VoteState>(
      builder: (context, voteState, child) {
        String activeVoteId = voteState.activeVote?.voteId ?? '';

        return Column(
          children: <Widget>[
            for (Vote vote in voteState.voteList)
              Card(
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      vote.voteTitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: activeVoteId == vote.voteId
                            ? Colors.white
                            : Colors.black,
                        fontWeight: activeVoteId == vote.voteId
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  selected: activeVoteId == vote.voteId ? true : false,
                  onTap: () {
                    voteState.activeVote = vote;
                  },
                ),
                color: activeVoteId == vote.voteId
                    ? Colors.red[200]
                    : alternateColor(),
              ),
          ],
        );
      },
    );
  }

  Function getAlternate({int start = 0}) {
    int indexNum = start;

    Color getColor() {
      Color color = Colors.teal[100];

      if (indexNum % 2 == 0) {
        color = Colors.blueAccent[100];
      }
      ++indexNum;
      return color;
    }

    return getColor;
  }
}
