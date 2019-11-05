/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import 'package:flutter/material.dart';
import 'package:flutter_firebase_vote/services/services.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_firebase_vote/state/vote.dart';
import 'package:flutter_firebase_vote/models/vote.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    retrieveActiveVoteData(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: createChart(context),
    );
  }

  Widget createChart(BuildContext context) {
    return Consumer<VoteState>(
      builder: (context, voteState, child) {
        return charts.BarChart(
          retrieveVoteResult(context, voteState),
          animate: true,
        );
      },
    );
  }

  List<charts.Series<VoteData, String>> retrieveVoteResult(
      BuildContext context, VoteState voteState) {
    Vote activeVote = voteState.activeVote;

    List<VoteData> data = List<VoteData>();
    for (var option in activeVote.options) {
      option.forEach((key, value) {
        data.add(VoteData(key, value));
      });
    }

    return [
      charts.Series<VoteData, String>(
        id: 'VoteResult',
        colorFn: (_, pos) {
          if (pos % 2 == 0) {
            return charts.MaterialPalette.green.shadeDefault;
          }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (VoteData vote, _) => vote.option,
        measureFn: (VoteData vote, _) => vote.total,
        data: data,
      )
    ];
  }

  void retrieveActiveVoteData(BuildContext context) {
    final voteId =
        Provider.of<VoteState>(context, listen: false).activeVote?.voteId;
    retrieveMarkedVoteFromFirestore(voteId: voteId, context: context);
  }
}

/// Sample ordinal data type.
class VoteData {
  final String option;
  final int total;

  VoteData(this.option, this.total);
}
