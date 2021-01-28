import 'package:flutter/material.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/enum/User_state.dart';
import 'package:karate_lecture/model/user.dart';
class OurDotIndicator extends StatefulWidget {
  final String uid;
  OurDotIndicator({this.uid});
  @override
  _OurDotIndicatorState createState() => _OurDotIndicatorState();
}

class _OurDotIndicatorState extends State<OurDotIndicator> {
  final OurDatabase database=OurDatabase();
  @override
  Widget build(BuildContext context) {
    getColor(int state){
      switch(OurUsername.numtoStaet(state)){
        case OurUserState.Offline:
          return Colors.red;
        case OurUserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }


    }
    return StreamBuilder(
      stream: database.getUserStream(uid: widget.uid),
      builder: (context,snapshot){
        OurUser user;
        if(snapshot.hasData&& snapshot.data.data != null){
          user=OurUser.fromMap(snapshot.data.data);
        }
        return Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(right: 8,top: 8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(user?.state)
          ),

        );
      },
    );
  }
}

