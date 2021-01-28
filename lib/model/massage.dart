import 'package:cloud_firestore/cloud_firestore.dart';

class OurMessage{
  String senderId;
  String receiverId;
  String type;
  String message;
  Timestamp timestamp;
  String photoUrl;

  OurMessage({this.senderId,this.receiverId,this.type,this.timestamp,this.message});
  //todo:this OurMassage.imageMsaage only will call when the user send image else OurMassage will call...
  OurMessage.imageMessage({this.senderId,this.receiverId,this.type,this.timestamp,this.photoUrl,this.message});
Map toMap(){
  var map=Map<String,dynamic>();
  map['senderId']=this.senderId;
  map['receiverId']=this.receiverId;
  map['type']=this.type;
  map['message']=this.message;
  map['timestamp']=this.timestamp;
  return map;

}
Map toImageMap(){
  var map=Map<String,dynamic>();
  map['senderId']=this.senderId;
  map['receiverId']=this.receiverId;
  map['type']=this.type;
  map['message']=this.message;
  map['timestamp']=this.timestamp;
  map['photoUrl']=this.photoUrl;
  return map;

}
OurMessage.fromMap(Map<String,dynamic> map){

  this.senderId=map['senderId'];
  this.receiverId=map['receiverId'];
  this.type=map['type'];
  this.message=map['message'];
  this.timestamp=map['timestamp'];
  this.photoUrl=map['photoUrl'];

}

}