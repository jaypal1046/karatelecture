

import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:karate_lecture/Screen/callScreen/PickUp/PickupLayout.dart';
import 'package:karate_lecture/Service/database/call_method.dart';
import 'package:karate_lecture/Setting/setting.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/model/call.dart';
import 'package:provider/provider.dart';
class OurCallScreen extends StatefulWidget {
  /// non-modifiable channel name of the page
  final OurCall call;


  /// non-modifiable client role of the page

  OurCallScreen({@required this.call});
  @override
  _OurCallScreenState createState() => _OurCallScreenState();
}

class _OurCallScreenState extends State<OurCallScreen> {
OurCallMethod callMethod=OurCallMethod();

StreamSubscription callStreamSubsctription;
final _users = <int>[];
final _infoStrings = <String>[];
bool muted = false;
RtcEngine _engine;
ClientRole _role = ClientRole.Broadcaster;


@override
void initState() {
  super.initState();
  CurrentState _currentUse=Provider.of<CurrentState>(context,listen: false);
  addPostFreamCallBack(_currentUse);
  OurCall callto=OurCall();
  String channal=callto.channelId;
  initializeAgora(channal);
}

Future<void> initializeAgora(String channal) async {

  if (APP_ID.isEmpty) {
    setState(() {
      _infoStrings.add(
        'APP_ID missing, please provide your APP_ID in settings.dart',
      );
      _infoStrings.add('Agora Engine is not starting');
    });
    return;
  }

  await _initAgoraRtcEngine();
  _addAgoraEventHandlers();
  // ignore: deprecated_member_use
  await _engine.enableWebSdkInteroperability(true);
  VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
  configuration.dimensions = VideoDimensions(1920, 1080);
  await _engine.setVideoEncoderConfiguration(configuration);
  await _engine.joinChannel(null, widget.call.receiverId,channal , 0);
}
/// Create agora sdk instance and initialize
Future<void> _initAgoraRtcEngine() async {
  _engine = await RtcEngine.create(APP_ID);
  await _engine.enableVideo();
  await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
  await _engine.setClientRole(_role);
}

/// Add agora event handlers
Future<void> _eventHandler() async {
  _engine = await RtcEngine.create(APP_ID);
  await _engine.enableVideo();
  await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
  await _engine.setClientRole(_role);
}

/// Add agora event handlers
void _addAgoraEventHandlers() {
  _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
    setState(() {
      final info = 'onError: $code';
      _infoStrings.add(info);
    });
  }, joinChannelSuccess: (channel, uid, elapsed) {
    setState(() {
      final info = 'onJoinChannel: $channel, uid: $uid';
      _infoStrings.add(info);
    });
  }, leaveChannel: (stats) {
    callMethod.endCall();
  }, userJoined: (uid, elapsed) {
    setState(() {
      final info = 'userJoined: $uid';
      _infoStrings.add(info);
      _users.add(uid);
    });
  }, userOffline: (uid, elapsed) {
    setState(() {
      final info = 'userOffline: $uid';
      _infoStrings.add(info);
      _users.remove(uid);
    });
  }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
    setState(() {
      final info = 'firstRemoteVideo: $uid ${width}x $height';
      _infoStrings.add(info);
    });
  }));
}

/// Helper function to get list of native views
List<Widget> _getRenderViews() {
  final List<StatefulWidget> list = [];
  if (_role == ClientRole.Broadcaster) {
    list.add(RtcLocalView.SurfaceView());
  }
  _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
  return list;
}
Widget _videoView(view) {
  return Expanded(child: Container(child: view));
}
Widget _expandedVideoRow(List<Widget> views) {
  final wrappedViews = views.map<Widget>(_videoView).toList();
  return Expanded(
    child: Row(
      children: wrappedViews,
    ),
  );
}

/// Video view wrapper




/// Video layout wrapper
Widget _viewRows() {
  final views = _getRenderViews();
  switch (views.length) {
    case 1:
      return Container(
          child: Column(
            children: <Widget>[_videoView(views[0])],
          ));
    case 2:
      return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow([views[0]]),
              _expandedVideoRow([views[1]])
            ],
          ));
    case 3:
      return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow(views.sublist(0, 2)),
              _expandedVideoRow(views.sublist(2, 3))
            ],
          ));
    case 4:
      return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow(views.sublist(0, 2)),
              _expandedVideoRow(views.sublist(2, 4))
            ],
          ));
    default:
  }
  return Container();
}

/// Toolbar layout
Widget _toolbar() {

  return Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.symmetric(vertical: 48),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: _onToggleMute,
          child: Icon(
            muted ? Icons.mic_off : Icons.mic,
            color: muted ? Colors.white : Colors.blueAccent,
            size: 20.0,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: muted ? Colors.blueAccent : Colors.white,
          padding: const EdgeInsets.all(12.0),
        ),
        RawMaterialButton(
          onPressed: (){
            callMethod.endCall(call: widget.call);
            Navigator.pop(context);


          },
          child: Icon(
            Icons.call_end,
            color: Colors.white,
            size: 35.0,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.redAccent,
          padding: const EdgeInsets.all(15.0),
        ),
        RawMaterialButton(
          onPressed: _onSwitchCamera,
          child: Icon(
            Icons.switch_camera,
            color: Colors.blueAccent,
            size: 20.0,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(12.0),
        )
      ],
    ),
  );
}

/// Info panel to show logs
Widget _panel() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 48),
    alignment: Alignment.bottomCenter,
    child: FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: ListView.builder(
          reverse: true,
          itemCount: _infoStrings.length,
          itemBuilder: (BuildContext context, int index) {
            if (_infoStrings.isEmpty) {
              return null;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _infoStrings[index],
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}



void _onToggleMute() {
  setState(() {
    muted = !muted;
  });
  _engine.muteLocalAudioStream(muted);
}

void _onSwitchCamera() {
  _engine.switchCamera();
}

@override
  void dispose() {
    // TODO: implement dispose

    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    callStreamSubsctription.cancel();
    super.dispose();

  }

void addPostFreamCallBack(CurrentState _currentUser) {
SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
 callStreamSubsctription=callMethod.callStreem(uid: _currentUser.getCurrentUser.uid).listen((DocumentSnapshot ds) {
  switch(ds.data){
    case null:
      Navigator.pop(context);
      break;
    default:
      break;
  }
 });
});
}
  @override
  Widget build(BuildContext context) {
    return OurPickupLayout(scaffold: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                ListTile(
                  title: Text(ClientRole.Broadcaster.toString(),style: TextStyle(
                      color: Colors.white
                  ),),
                  leading: Radio(
                    value: ClientRole.Broadcaster,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(ClientRole.Audience.toString(),style: TextStyle(
                      color: Colors.white
                  ),),
                  leading: Radio(
                    value: ClientRole.Audience,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                )
              ],
            ),

            _viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),

      ),
    );
  }


}
