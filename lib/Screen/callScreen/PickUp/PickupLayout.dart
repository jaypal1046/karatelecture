import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karate_lecture/Screen/callScreen/PickUp/PickUpscreen.dart';
import 'package:karate_lecture/Service/database/call_method.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/State/getUseruid.dart';
import 'package:karate_lecture/model/call.dart';
import 'package:provider/provider.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
class OurPickupLayout extends StatelessWidget {
  final Widget scaffold;
  final OurCallMethod callMethod = OurCallMethod();

  OurPickupLayout({@required this.scaffold});

  @override
  Widget build(BuildContext context) {
    UserProvider _currentUse = Provider.of<UserProvider>(
        context, listen: false);
    CurrentState _state = Provider.of<CurrentState>(context, listen: false);

    return (_state != null && _state.getCurrentUser.uid != null) ?
    StreamBuilder<DocumentSnapshot>(
        stream: getdata(_currentUse),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          print("${_state.getCurrentUser.uid} checking uid");
          // print("${snapshot.data.data()} checking id");
          if(snapshot.connectionState==ConnectionState.done){
            if (snapshot.hasData && snapshot.data.data != null) {
              OurCall call = OurCall.fromMap(snapshot.data.data());
              if (!call.hasDialled) {
                return OurPickupScreen(call: call);
              } else {
                return scaffold;
              }
            }
          }

          return scaffold;
        }


    ) : Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
Stream<DocumentSnapshot> getdata(_currentUse){
  final sn=FirebaseFirestore.instance.collection(Call_COLLECTION).doc(
      _currentUse.getUser.uid).snapshots();

  return sn;
}