import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/home/groupVideo/groupVideoCall.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OurLecturejoin extends StatefulWidget {
  bool isAudioOnly;
  bool isAudioMuted;
  bool isVideoMuted;
  OurLecturejoin(this.isAudioOnly, this.isAudioMuted, this.isVideoMuted);

  @override
  _OurLecturejoinState createState() => _OurLecturejoinState();
}

class _OurLecturejoinState extends State<OurLecturejoin> {
  TextEditingController _lectureIdContrioller = TextEditingController();
  void _joinlecture(BuildContext context, String roomNames) async {
    String roomName = roomNames;
    CurrentState _currentUse =
        Provider.of<CurrentState>(context, listen: false);
    String subject = ".";
    String _returnString = await OurDatabase()
        .joinVideolecture(roomName, subject, _currentUse.getCurrentUser.uid);
    if (_returnString == SUCCESS_FIELD) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => OurGroupVideoCall(widget.isVideoMuted,
                  widget.isAudioMuted, widget.isAudioOnly, roomName)),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                BackButton(),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContener(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _lectureIdContrioller,
                    decoration: InputDecoration(hintText: "lectureId"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 95),
                      child: Text(
                        'Join',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        _joinlecture(context, _lectureIdContrioller.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
