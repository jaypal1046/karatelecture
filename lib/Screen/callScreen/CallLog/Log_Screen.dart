import 'package:flutter/material.dart';
import 'package:karate_lecture/Screen/callScreen/CallLog/Widget/LogListContainer.dart';
import 'package:karate_lecture/Screen/callScreen/CallLog/Widget/floating_Colume.dart';
import 'package:karate_lecture/Screen/callScreen/PickUp/PickupLayout.dart';
import 'package:karate_lecture/Util/CustomeAppBar.dart';
class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: CustomeAppBar(
          title: "Calls",
           action: <Widget>[
             IconButton(
               icon: Icon(
                 Icons.search,
                 color: Colors.black87,
               ),
               onPressed: (){
                 Navigator.pushNamed(context, "/SearchScreen");

               },

             ),
           ],
         ),
         // floatingActionButton: FloatingColume(),
          body: Padding(
            padding: EdgeInsets.only(left: 15),
            child: LogListContainer(

            ),
          ),

    );
  }
}
