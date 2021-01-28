import 'package:cloud_firestore/cloud_firestore.dart';

class OurCall{
  String callerId;
  String callerUsername;
  String callerPic;
  String receiverUsername;
  String receiverId;
  String receiverPic;
  String channelId;
  bool hasDialled;
  Timestamp callStarted;
  OurCall({
    this.callerId,
    this.callerUsername,
    this.callerPic,
    this.receiverId,
    this.receiverUsername,
    this.receiverPic,
    this.channelId,
    this.callStarted,
    this.hasDialled,
});
  Map<String,dynamic> toMap(OurCall call){
    Map<String ,dynamic> callMap=Map();
    callMap["callerId"]=call.callerId;
    callMap["callerUsername"]=call.callerUsername;
    callMap["callerPic"]=call.callerPic;
    callMap["receiverId"]=call.receiverId;
    callMap["receiverUsername"]=call.receiverUsername;
    callMap["receiverPic"]=call.receiverPic;
    callMap["channelId"]=call.channelId;
    callMap["hasDialled"]=call.hasDialled;
    callMap["callStarted"]=call.callStarted;
    return callMap;
  }

  OurCall.fromMap(Map callMap){
    this.callerId =callMap["callerId"];
    this.callerUsername=callMap["callerUsername"];
    this.callerPic= callMap["callerPic"];
    this.receiverId=callMap["receiverId"];
    this.receiverUsername=callMap["receiverUsername"];
    this.receiverPic=callMap["receiverPic"];
    this.channelId=callMap["channelId"];
    this.hasDialled=callMap["hasDialled"];
    this.callStarted=callMap["callStarted"];
  }

}