import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';

import 'package:karate_lecture/Service/LocalDB/Repo/Repo.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/Widget/OurCustomTitle.dart';
import 'package:karate_lecture/Widget/cached_image.dart';
import 'package:karate_lecture/home/ChatListScreen/Quiet_box.dart';
import 'package:karate_lecture/model/Log.dart';
import 'package:provider/provider.dart';
class LogListContainer extends StatefulWidget {
  @override
  _LogListContainerState createState() => _LogListContainerState();
}

class _LogListContainerState extends State<LogListContainer> {
  getIcon(String callStatus) {
    
    Icon _icon;
    double _iconSize = 15;

    switch (callStatus) {
      case CALL_STATUS_DIALLED:
        
        print("$callStatus $CALL_STATUS_DIALLED");
        _icon = Icon(
          Icons.call_made,
          size: _iconSize,
          color: Colors.green,
        );
        break;

      case CALL_STATUS_MISSED:
        print("$callStatus $CALL_STATUS_MISSED");
        _icon = Icon(
          Icons.call_missed,
          color: Colors.red,
          size: _iconSize,
        );
        break;

      default:
        print("$callStatus default");
        _icon = Icon(
          
          Icons.call_received,
          size: _iconSize,
          color: Colors.grey,
        );
        break;
    }

    return Container(
      margin: EdgeInsets.only(right: 5),
      child: _icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
     // future: LogRepository.getLogs(),
      builder: ( context,AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          List<dynamic> logList = snapshot.data;

          if (logList.isNotEmpty) {
            return ListView.builder(
              itemCount: logList.length,
              itemBuilder: (context, i) {
                Log _log = logList[i];
                bool hasDialled = _log.callStatus == CALL_STATUS_DIALLED;
                if(hasDialled==true){
                  CurrentState state= Provider.of<CurrentState>(context,listen: false);
                  if(_log.receiverUsername==state.getCurrentUser.username){
                    hasDialled=false;
                  }
                }
                else{
                  print("jaypal1046");
                }



                return OurContener(child: OurCustomTitle(
                  leading: OurCachedImage(
                    hasDialled ? _log.receiverPic : _log.callerPic,
                    isRound: true,
                    radius: 45,
                  ),
                  mini: false,
                  ontap:  () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete this Log?"),
                      content:
                      Text("Are you sure you wish to delete this log?"),
                      actions: [
                        FlatButton(
                          child: Text("YES"),
                          onPressed: () async {
                            Navigator.maybePop(context);
                           // await LogRepository.deleteLogs(i);
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                        FlatButton(
                          child: Text("NO"),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    hasDialled ? _log.receiverUsername : _log.callerUsername,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  icon: getIcon(_log.callStatus),
                  subtitle: Text(
                    OurUsername.formatDateString(_log.timestamp),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),);
              },
            );
          }
          return OurQuiteBox(

          );
        }

        return OurQuiteBox(
        );
      },
    );
  }
}