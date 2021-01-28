import 'package:cloud_firestore/cloud_firestore.dart';

class OurVideoLecture{
  String lectureUid;
  String subject;
  String roomName;
  List<String> member;
  String creatorUid;
  Timestamp lectureCreated;
  OurVideoLecture({
    this.lectureUid,
    this.subject,
    this.creatorUid,
    this.roomName,
    this.member,
    this.lectureCreated,

});
  Map toMap(OurVideoLecture user){
    var data=Map<String,dynamic>();
    data['lectureUid']=user.lectureUid;
    data['subject']=user.subject;
    data['roomName']=user.roomName;
    data['member']=user.member;
    data['creatorUid']=user.creatorUid;
    data['lectureCreated']=user.lectureCreated;
    return data;

  }
  OurVideoLecture.fromMap(Map<String,dynamic>map){
    this.lectureUid=map['lectureUid'];
    this.subject=map['subject'];
    this.roomName=map['roomName'];
    this.member=map['member'];
    this.creatorUid=map['creatorUid'];
    this.lectureCreated=map['lectureCreated'];



  }


}