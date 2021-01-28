import 'package:flutter/material.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:provider/provider.dart';
import'package:karate_lecture/Util/username.dart';
class UserCircle extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final CurrentState useprovider=Provider.of<CurrentState>(context,listen: false);
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey,
      ),
      child: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.center,
            child: Text( useprovider.getCurrentUser.username ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 13,

              ),),

          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2
                ),
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }

}