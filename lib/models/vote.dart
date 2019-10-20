/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */

class Vote {
  String voteId;
  String voteTitle;
  List<Map<String, int>> options;

  Vote({this.voteId, this.voteTitle, this.options});
}

class Voter {
  String uid;
  String voteId;
  int markedVoteOption;
}
