import 'package:flutter/cupertino.dart';
/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import "package:flutter_firebase_vote/models/vote.dart";
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import "package:flutter_firebase_vote/state/vote.dart";

List<Vote> getVoteList() {
  // Mock Data
  List<Vote> voteList = List<Vote>();

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Mobile Frameworks?',
    options: [
      {'Flutter': 70},
      {'React Native': 10},
      {'Xamarin': 1},
    ],
  ));

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Web Frontend Frameworks?',
    options: [
      {'React': 80},
      {'Angular': 40},
      {'Vue': 20},
    ],
  ));

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Web Backend Frameworks?',
    options: [
      {'Django': 50},
      {'Laravel': 30},
      {'Express.js': 50},
    ],
  ));

  return voteList;
}

// firestore collection name
const String kVotes = 'votes';
const String kTitle = 'title';

void getVoteListFromFirestore(BuildContext context) async {
//  Firestore.instance.collection(kVotes).snapshots().listen((data) {
//    List<Vote> voteList = List<Vote>();
//
//    data.documents.forEach((DocumentSnapshot document) {
//      Vote vote = Vote(voteId: document.documentID);
//
//      List<Map<String, int>> options = List();
//
//      document.data.forEach((key, value) {
//        if (key == kTitle) {
//          vote.voteTitle = value;
//        } else {
//          options.add({key: value});
//        }
//      });
//
//      vote.options = options;
//      voteList.add(vote);
//    });
//
//    Provider.of<VoteState>(context, listen: false).voteList = voteList;
//  });

  Firestore.instance.collection(kVotes).getDocuments().then((snapshot) {
    List<Vote> voteList = List<Vote>();

    snapshot.documents.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));
    });

    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });
}

Vote mapFirestoreDocToVote(document) {
  Vote vote = Vote(voteId: document.documentID);
  List<Map<String, int>> options = List();
  document.data.forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

void markVote(String voteId, String option) async {
  // increment value

  Firestore.instance.collection(kVotes).document(voteId).updateData({
    option: FieldValue.increment(1),
  });
}

void retrieveMarkedVoteFromFirestore({String voteId, BuildContext context}) {
  // Retrieve updated doc from server
  Firestore.instance.collection(kVotes).document(voteId).get().then((document) {
    Provider.of<VoteState>(context, listen: false).activeVote =
        mapFirestoreDocToVote(document);
  });
}
