import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karate_lecture/Service/user.dart';

class Database{
  CollectionReference users=FirebaseFirestore.instance.collection("User");
  Future<String> createUser(OurUser user) async {
 //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String retVal = "error";
      users.add({
        'uid':user.uid,
        'username':user.username,
        'fullname':user.fullName,
        'profile':user.profilePhoto,
        'room':user.roomName,
        'email':user.email,
      }).then((value) => print("User Added")).catchError((error)=>print("Failed to add user:$error"));
      print("${user.username}");
    print("${user.email}");
    print("${user.roomName}");
      retVal = "success";
    return retVal;
  }

}