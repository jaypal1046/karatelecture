import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';

import 'package:karate_lecture/Screen/callScreen/callScreen.dart';
import 'package:karate_lecture/Service/LocalDB/Repo/Repo.dart';
import 'package:karate_lecture/Service/database/call_method.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/model/Log.dart';
import 'package:karate_lecture/model/call.dart';
import 'package:karate_lecture/model/user.dart';

class OurCallUtill{
  static final OurCallMethod callMethod=OurCallMethod();
  static dial({
OurUser from,
    OurUser to,
    context
})async{
    const _chars = 'abcdefghijklmnopqrstuvwxyz';
    Random _rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    OurCall call=OurCall(
    callerId: from.uid,
      callerUsername: from.username,
    callStarted:
      Timestamp.now(),
    callerPic: from.profilePhoto,
    receiverId: to.uid,
    receiverUsername: to.username,
    receiverPic: to.profilePhoto,
    channelId: getRandomString(10),


  );
  Log log=Log(
   callerUsername:  from.username,
    callerPic: from.profilePhoto,
    callStatus: CALL_STATUS_DIALLED,
    receiverUsername: to.username,
    receiverPic: to.profilePhoto,
    timestamp: DateTime.now().toString(),

  );
  bool callMade=await callMethod.makeCall(call: call);
  call.hasDialled=true;
  if(callMade){
   // LogRepository.addLogs(log);
    print(log);
    Navigator.push(context,
        MaterialPageRoute(
          builder: (context)=>OurCallScreen(call:call),
        ));
  }
  }
}