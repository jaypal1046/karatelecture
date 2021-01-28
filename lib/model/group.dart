import 'package:cloud_firestore/cloud_firestore.dart';

class OurGroup{
  String id;
  String name;
  String leader;
  List<String> members;
  String channalId;
  Timestamp groupCreated;

  Timestamp currentMeetingDue;
  OurGroup({
    this.id,
    this.name,
    this.leader,
    this.channalId,
    this.members,
    this.groupCreated,

    this.currentMeetingDue,

});
}