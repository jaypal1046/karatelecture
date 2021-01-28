
import 'package:flutter/material.dart';
import 'package:karate_lecture/Screen/ChatScreen/ChatScreen.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/Util/call_utill.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/Widget/OurCustomTitle.dart';
import 'package:karate_lecture/Widget/cached_image.dart';
import 'package:karate_lecture/home/ChatListScreen/Widget/Online_Dot_Indicator.dart';
import 'package:karate_lecture/home/ChatListScreen/Widget/last_massage_container.dart';
import 'package:karate_lecture/model/Contact.dart';
import 'package:karate_lecture/model/user.dart';
import 'package:provider/provider.dart';
class OurContactView extends StatelessWidget {
  final OurContact contact;
  final OurDatabase _database=OurDatabase();
  OurContactView({
    this.contact
});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OurUser>(
        builder: (context,snapshot){
          if(snapshot.hasData){
            OurUser ourUser=snapshot.data;
            return ViewLayout(contact: ourUser);


          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
            future: _database.getUserDetailById(contact.Contact_id),
    );

    
  }
}
class ViewLayout extends StatelessWidget {

  final OurUser contact;
  final OurDatabase database=OurDatabase();
  ViewLayout({@required this.contact});
  @override
  Widget build(BuildContext context) {
    final CurrentState usrProvider=Provider.of<CurrentState>(context,listen: false);
    return OurContener(
      child: OurCustomTitle(
        mini: true,
        ontap: ()=>Navigator.push(context,MaterialPageRoute(
            builder: (context)=>OurChatScreen(
              receiver: contact,
            )
        )),
        title: Text(OurUsername.getUsername(contact.email),
          style: TextStyle(color: Colors.black87,fontFamily: "Arial",fontSize: 19),
        ),
        subtitle:OurLastMassageContainer(
          stream: database.fatchLastMessageBetween(senderId: usrProvider.getCurrentUser.uid, reciverId: contact.uid),
        ),
        leading: Container(
          constraints: BoxConstraints(maxHeight: 50,maxWidth: 50),
          child: Stack(
            children: <Widget>[
              OurCachedImage(
                contact.profilePhoto,
                isRound: true,
                radius: 80,
              ),
              //OurDotIndicator(uid: contact.uid,)
            ],
          ),
        ),
      ),
    ) ;

  }
}

