import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Screen/ChatScreen/Widget/ImageView.dart';
import 'package:karate_lecture/Service/database/firebase_repo.dart';
import 'package:karate_lecture/State/OurImageProvider.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/State/getUseruid.dart';
import 'package:karate_lecture/Util/UniversalVariable.dart';
import 'package:karate_lecture/Util/call_utill.dart';
import 'package:karate_lecture/Util/permission_handle.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/Widget/OurAppBar.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/Widget/OurCustomTitle.dart';
import 'package:karate_lecture/Widget/cached_image.dart';
import 'package:karate_lecture/enum/OurEnum.dart';
import 'package:karate_lecture/model/massage.dart';
import 'package:karate_lecture/model/user.dart';
import 'package:provider/provider.dart';
class OurChatScreen extends StatefulWidget {
  final OurUser receiver;
  OurChatScreen( { this.receiver});
  @override
  _OurChatScreenState createState() => _OurChatScreenState();
}
class _OurChatScreenState extends State<OurChatScreen> {
  TextEditingController textFieldController=TextEditingController();
  FirebaseRepo _repo=FirebaseRepo();
  ScrollController _listScrollController=ScrollController();
  ImageUploadProvider _imageUploadProvider;
  OurUser sender;
  String currentUserId;

  FocusNode textFieldFocus=FocusNode();
  bool isWriting=false;
  bool showEmojiPicker=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentState _currentUse=Provider.of<CurrentState>(context,listen: false);
    UserProvider _provider=Provider.of<UserProvider>(context,listen:false);
  //  ImageUploadProvider _imageUploadProvider=Provider.of<ImageUploadProvider>(context);
    currentUserId=_currentUse.getCurrentUser.uid;
    setState(() {
      sender=OurUser(
        uid: _currentUse.getCurrentUser.uid==null?_provider.getUser.uid:_currentUse.getCurrentUser.uid,
        fullName: _currentUse.getCurrentUser.fullName==null?_provider.getUser.fullName:_currentUse.getCurrentUser.fullName,
        profilePhoto: _currentUse.getCurrentUser.profilePhoto==null?_provider.getUser.profilePhoto:_currentUse.getCurrentUser.profilePhoto,
        username: _currentUse.getCurrentUser.username==null?_provider.getUser.username:_currentUse.getCurrentUser.username,
      );
    });
  }
  showKeyboard()=>textFieldFocus.requestFocus();
  hideKeyboard()=>textFieldFocus.unfocus();
  hideEmojiContainer(){
    setState(() {
      showEmojiPicker=false;
    });
  }
  showEmojiContiner(){
    setState(() {
showEmojiPicker=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider=Provider.of<ImageUploadProvider>(context);
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: <Widget>[
          Flexible(
              child: massageList(),),
          _imageUploadProvider.getViewState==OurViewState.LOADING?
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 15),
            child: CircularProgressIndicator(),):
              Container(),
          ChatControls(),
          showEmojiPicker?Container(child: emojiContainer(),):Container(),
        ],
      ),
    );
  }

  emojiContainer(){
    return EmojiPicker(
      indicatorColor: UniversalVrialbes.blueColor,
        rows: 3,
        columns: 7,
        onEmojiSelected: (emoji,category){
        setState(() {
          isWriting=true;
        });
        textFieldController.text=textFieldController.text+emoji.emoji;
        },
        recommendKeywords: ['face','happy','party','sad'],
      numRecommended: 50,
        );

  }

  Widget massageList(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(MESSAGE_COLLECTION).doc(currentUserId).collection(widget.receiver.uid).orderBy(TIMESTAMP_FIELD,descending: true ).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.data==null){
          return Center(child:CircularProgressIndicator()
            ,);
        }
       /* SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _listScrollController.animateTo(_listScrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut);
        });*/

          return ListView.builder(
            padding: EdgeInsets.all(10),
              itemCount: snapshot.data.docs.length,
              reverse: true,
            controller: _listScrollController,
            itemBuilder: (context,index){
              return chatMessageItem(snapshot.data.docs[index]);
              },
              );
        });
  }
  Widget chatMessageItem( DocumentSnapshot snapshot){
      
    OurMessage _message=OurMessage.fromMap(snapshot.data());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: _message.senderId==currentUserId?Alignment.centerRight:Alignment.centerLeft,

        child:_message.senderId==currentUserId? senderLayout(_message):receverLayout(_message),
      ),
    );
}
Widget senderLayout(OurMessage message){
    Radius massageRadius=Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:  BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width* 0.65
      ),
      decoration: BoxDecoration(
        color: UniversalVrialbes.senderColor,
        borderRadius: BorderRadius.only(
        topLeft: massageRadius,
          topRight: massageRadius,
          bottomLeft: massageRadius,
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            if(message.type=="image"){
              Navigator.push(context, MaterialPageRoute(
                builder: (_)=>OurImageView(message)
              ));
            }
          },
         child: getMessage(message),
        )
      ),
    );

}
  getMessage(OurMessage message){
   return message.type!=MESSAGE_TYPE_IMAGE?
 Text(
    message.message,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ):message.photoUrl!=null?OurCachedImage(
       message.photoUrl,width: 250,
     height: 250, radius: 10,

   ):
   Text("Url is null check that You selected corette image");
}
Widget receverLayout(OurMessage message){

    Radius massageRadius=Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:  BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.56),
      decoration: BoxDecoration(
          color: UniversalVrialbes.reciverColor,
          borderRadius: BorderRadius.only(
            bottomRight:massageRadius,
            topRight: massageRadius,
            bottomLeft: massageRadius,

          )
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child:GestureDetector(
          onTap: (){
            if(message.type=="image"){
              Navigator.push(context, MaterialPageRoute(
                  builder: (_)=>OurImageView(message)
              ));
            }
          },
          child: getMessage(message),
        )
      ),
    );


}
  Widget ChatControls(){
    setWritingTo(bool val){
      setState(() {
        isWriting=val;
      });
    }
    addMediaModel(context){
      showModalBottomSheet(
          context: context,
          elevation: 0,

          builder: (context){
            return Column(
              children: <Widget>[
                SizedBox(
                height: 80,
                  child: Row(
                    children: <Widget>[

                      SizedBox(
                        height: 10,
                        width: 60,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton(

                            onPressed: ()=>Navigator.maybePop(context),
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: OurContener(
                              child: Text(
                                "Content and tools",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ))
                      
                    ],
                  ),
                ),
                Flexible(
                    child: ListView(
                      children: <Widget>[
                       OurContener(
                         child:  ModelTitle(
                           title: "Media",
                           subtitle: "Share Photos",

                           icon: Icons.image,
                           onTap: ()=>pickImage(ImageSource.camera),
                         ),
                       ),
                        OurContener(
                          child:  ModelTitle(
                            title: "galary",
                            subtitle: "Share Photos",

                            icon: Icons.image,
                            onTap: ()=>pickImage(ImageSource.gallery),
                          ),
                        ),

                      ],
                    )
                )
              ],
            );
          });
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
         GestureDetector(
           onTap: ()=>addMediaModel(context),
           child:  Container(
             padding: EdgeInsets.all(5),
             decoration: BoxDecoration(
               gradient: UniversalVrialbes.fabGradint,
               shape: BoxShape.circle,
             ),
             child: Icon(Icons.add),
           ),
         ),
          SizedBox(width: 1,),
          Expanded(child: Stack(
            children: <Widget>[


              TextField(

                controller: textFieldController,
                focusNode: textFieldFocus,
                onTap: ()=>hideEmojiContainer(),
                style: TextStyle(
                  color: Colors.white,
                ),
                onChanged: (val){
                  (val.length>0 && val.trim() != "")?setWritingTo(true):setWritingTo(false);
                },

                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none,

                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,vertical: 5,
                  ),
                  filled: true,
                  fillColor: UniversalVrialbes.separtorColor,



                ),

              ),



            ],
          )
          ),
          isWriting?Container(): IconButton(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onPressed: (){
              if(!showEmojiPicker){
                hideKeyboard();
                showEmojiContiner();
              }
              else{
                showKeyboard();
                hideEmojiContainer();
              }
            },

            icon: Icon(Icons.insert_emoticon,color: Colors.yellowAccent,size: 25,),
          ),

         isWriting?Container(): GestureDetector(
           onTap: ()=>pickImage(ImageSource.camera),
           child: Icon(
    Icons.camera_alt,),
          ),
          isWriting? Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: UniversalVrialbes.fabGradint,
              shape: BoxShape.circle,
            ),
            child: IconButton(icon: Icon(Icons.send,size: 15,),
                onPressed:()=> sendMessage(),

            ),
          ):Container()
        ],
      ),
    );
  }
  pickImage(@required ImageSource source) async{
      File selectedImage=await OurUsername.pickImage(source);
      if(selectedImage != null){
        _repo.uploadImage(
          image: selectedImage,
          receiverId:   widget.receiver.uid,
          senderId:currentUserId,
          imageProvider: _imageUploadProvider,

        );
        Navigator.pop(context);
      }else{
        Navigator.pop(context);
      }



  }
  sendMessage(){
    var text=textFieldController.text;
     OurMessage message=  OurMessage(
       receiverId: widget.receiver.uid,
       senderId: sender.uid,
       message: text,
       timestamp: Timestamp.now(),
       type: 'text',

     );
     setState(() {
       isWriting=false;
       WidgetsBinding.instance.addPostFrameCallback((_)=>textFieldController.clear());
     });
     _repo.addMessagetoDb(message, sender, widget.receiver);

  }
  OurAppBar customAppBar(context){
    return OurAppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          }),
      centerTitle: false,
      title: OurContener(
        child: Text(widget.receiver.username),
      ),
      action: <Widget>[
        IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () async => await Permissions.cameraAndMicrophonePermissionsGranted()?

            OurCallUtill.dial(
              from: sender,
              to: widget.receiver,
              context: context,
            ):{

            }
        ),

      ],
    );

   }
}
class ModelTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;
  const ModelTitle({@required this.title,@required this.subtitle,@required this.icon,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15 ),
      child: OurCustomTitle(
        mini: false,
        ontap: onTap,
        leading:Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: UniversalVrialbes.reciverColor,
          ),
          padding: EdgeInsets.all(10),
          child: Icon(icon,
            color: UniversalVrialbes.grayColor,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: UniversalVrialbes.blackColor,
            fontSize: 14,
          ),
        ),
        title: Text(
          title,style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 18,
        ),
        ),
      ),
    );
  }
}

