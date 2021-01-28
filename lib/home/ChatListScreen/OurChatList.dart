import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karate_lecture/Screen/callScreen/CallLog/Log_Screen.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/Util/CustomeAppBar.dart';
import 'package:karate_lecture/home/ChatListScreen/Quiet_box.dart';
import 'package:karate_lecture/home/ChatListScreen/Widget/CircleImage.dart';
import 'package:karate_lecture/home/ChatListScreen/Widget/New_chatbutton.dart';
import 'package:karate_lecture/home/ChatListScreen/Widget/contact_view.dart';
import 'package:karate_lecture/model/Contact.dart';

import 'package:provider/provider.dart';

class OurChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: UserCircle(),
        action: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/SearchScreen");
            },
          ),
          IconButton(
              icon: Icon(
                Icons.call_made,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LogScreen(),
                    ));
              })
        ],
      ),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final OurDatabase database = OurDatabase();
  @override
  Widget build(BuildContext context) {
    final CurrentState userProvider =
        Provider.of<CurrentState>(context, listen: false);
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: database.fetchContact(
              userId: userProvider.getCurrentUser.uid,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // ignore: deprecated_member_use
                var docList = snapshot.data.documents;
                if (docList.isEmpty) {
                  return OurQuiteBox();
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: docList.length,
                  itemBuilder: (context, index) {
                    OurContact contact =
                        OurContact.fromMap(docList[index].data());
                    return OurContactView(
                      contact: contact,
                    );
                  },
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
/*Widget userCircle(String text){
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.grey,
    ),
    child: Stack(
      children: <Widget>[

        Align(
          alignment: Alignment.center,
          child: Text( "jaypal",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
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
}*/

/*class UserCircle extends StatelessWidget{

  final String text;



  UserCircle(this.text);
  /*void jay(String text){
    print(text);

  }*/

  @override
  Widget build(BuildContext context) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.grey,
    ),
    child: Stack(
      children: <Widget>[

        Align(
          alignment: Alignment.center,
          child: Text( text,
            style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
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
  }*/
