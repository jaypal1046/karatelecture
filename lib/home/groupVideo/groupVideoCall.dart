import 'dart:io';
import 'package:flutter/material.dart';

import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/home/groupVideo/groupLecturehome.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OurGroupVideoCall extends StatefulWidget {
  bool isVideoMuted;
  bool isAudioMuted;
  bool isAudioOnly;
  String room;

  OurGroupVideoCall(
      this.isVideoMuted, this.isAudioMuted, this.isAudioOnly, this.room);

  @override
  _OurGroupVideoCallState createState() => _OurGroupVideoCallState();
}

class _OurGroupVideoCallState extends State<OurGroupVideoCall> {
  final serverText = "https://meet.jit.si/karate_lecture/";
  String room;
  String uid;
  String email;
  String userName;
  bool isVideoMuted;
  bool isAudioMuted;
  bool isAudioOnly;
  String subject = "meeting";

  @override
  void initState() {
    super.initState();
    isVideoMuted = widget.isVideoMuted;
    isAudioMuted = widget.isAudioMuted;
    isAudioOnly = widget.isAudioOnly;
    room = widget.room;
    print(room);
    print("jay pal room");
    CurrentState _currentUse =
        Provider.of<CurrentState>(context, listen: false);
    email = _currentUse.getCurrentUser.email;
    userName = _currentUse.getCurrentUser.username;
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    _joinMeeting();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  /*_onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }*/

  /*_onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }*/

  _joinMeeting() async {
    String serverUrl = serverText.toString()?.trim()?.isEmpty ?? ""
        ? null
        : serverText.toString();

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = room
        ..serverURL = serverUrl
        ..subject = subject
        ..userDisplayName = userName
        ..userEmail = email
        ..audioOnly = widget.isAudioOnly
        ..audioMuted = widget.isAudioMuted
        ..videoMuted = widget.isVideoMuted;
      //  ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OurGroupLectureHome()));
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      // ignore: unused_field
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Material();
  }
}
