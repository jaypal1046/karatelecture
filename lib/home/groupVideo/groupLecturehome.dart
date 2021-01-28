import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Screen/Lecturejoin/lectureCreate.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/Widget/OurAppBar.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/home/groupVideo/groupVideoCall.dart';

import 'package:provider/provider.dart';

import 'dart:math';

class OurGroupLectureHome extends StatefulWidget {
  @override
  _OurGroupLectureHomeState createState() => _OurGroupLectureHomeState();
}

class _OurGroupLectureHomeState extends State<OurGroupLectureHome> {
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;
  void _gotoCreate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OurLecturejoin(isAudioOnly, isAudioMuted, isVideoMuted)));
  }

  void _gotojoin(BuildContext context) async {
    const _chars = 'abcdefghijklmnopqrstuvwxyz';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    CurrentState _currentUse =
        Provider.of<CurrentState>(context, listen: false);
    String roomName = getRandomString(10);
    String subject = "jay";
    String _returnString = await OurDatabase()
        .createVideoLecture(roomName, subject, _currentUse.getCurrentUser.uid);
    if (_returnString == SUCCESS_FIELD) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OurGroupVideoCall(
                  isAudioOnly, isAudioMuted, isVideoMuted, roomName)));
    }
  }

  OurAppBar customeAppBar(BuildContext context) {
    return OurAppBar(
      title: OurContener(
        child: Text('Create Or Join Video lecture'),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(context),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          // SizedBox(height: 30,),
          OurContener(
              child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 45)),
                  RawMaterialButton(
                    onPressed: _onVideoMute,
                    child: Icon(
                      isAudioOnly ? Icons.audiotrack : Icons.video_call,
                      color: isAudioOnly ? Colors.black87 : Colors.black87,
                      size: 30.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: isAudioOnly ? Colors.white : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  ),
                  RawMaterialButton(
                    onPressed: _onToggleMute,
                    child: Icon(
                      isAudioMuted ? Icons.mic_off : Icons.mic,
                      color: isAudioMuted ? Colors.white : Colors.black87,
                      size: 30.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: isAudioMuted ? Colors.redAccent : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  ),
                  RawMaterialButton(
                    onPressed: _onVideoOff,
                    child: Icon(
                      isVideoMuted ? Icons.videocam_off : Icons.videocam,
                      color: isVideoMuted ? Colors.white : Colors.black87,
                      size: 30.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: isVideoMuted ? Colors.redAccent : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 10)),
                  SizedBox(
                    child: RaisedButton(
                      onPressed: () {
                        _gotoCreate(context);
                      },
                      child: Text(
                        "Join Meeting",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: RaisedButton(
                      onPressed: () {
                        _gotojoin(context);
                      },
                      child: Text(
                        "Create a meeting",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _onVideoMute() {
    setState(() {
      isAudioOnly = !isAudioOnly;
    });
  }

  void _onToggleMute() {
    setState(() {
      isAudioMuted = !isAudioMuted;
    });
  }

  void _onVideoOff() {
    setState(() {
      isVideoMuted = !isVideoMuted;
    });
  }
}
