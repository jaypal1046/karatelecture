import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';

import 'package:karate_lecture/Screen/callScreen/callScreen.dart';
import 'package:karate_lecture/Service/LocalDB/Repo/Repo.dart';
import 'package:karate_lecture/Service/database/call_method.dart';
import 'package:karate_lecture/Util/permission_handle.dart';
import 'package:karate_lecture/Widget/cached_image.dart';
import 'package:karate_lecture/model/Log.dart';
import 'package:karate_lecture/model/call.dart';
class OurPickupScreen extends StatefulWidget {
  final OurCall call;

  OurPickupScreen({
    @required this.call,
});

  @override
  State<StatefulWidget> createState() =>_PickUpScreenState();
}

class _PickUpScreenState extends State<OurPickupScreen>{
  final OurCallMethod callMethod=OurCallMethod();
  bool isCallMissed=true;
  addToLocalStorage( {@required String callStatus}){
  Log log =Log(
    callerUsername:  widget.call.callerUsername,
    callerPic: widget.call.callerPic,
    receiverPic: widget.call.receiverPic,
    receiverUsername: widget.call.receiverUsername,
    timestamp: DateTime.now().toString(),
    callStatus: callStatus,
  );
 // LogRepository.addLogs(log);
  }

  @override
  void dispose() {
    super.dispose();
    if(isCallMissed){
      addToLocalStorage(callStatus: CALL_STATUS_MISSED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Incoming...",style: TextStyle(
                fontSize: 30
            ),
            ),
            SizedBox(height:50,),
            OurCachedImage(widget.call.callerPic,height: 150,width: 150,),
            SizedBox(height:15,),
            Text(
              widget.call.receiverUsername,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 75,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: ()async{
                    isCallMissed=false;
                   await addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                    await callMethod.endCall(call: widget. call);
                  },
                ),
                SizedBox(width: 25,),
                IconButton(icon: Icon(Icons.call),
                    color: Colors.green,
                    onPressed: ()async{
                  isCallMissed=false;
                  addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);

                      await Permissions.cameraAndMicrophonePermissionsGranted()?
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>OurCallScreen(call: widget.call))
                      ):(){

                      };
                    }
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}


