import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/State/OurImageProvider.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/enum/User_state.dart';

import 'package:karate_lecture/model/massage.dart';
import 'package:karate_lecture/model/user.dart';

class OurDatabase {

  CollectionReference users=FirebaseFirestore.instance.collection("User");
  final FirebaseFirestore  _firestore = FirebaseFirestore.instance;

  firebase_storage.StorageReference _storageReference;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection(USER_COLLECTION);

  Future<String> createUser(OurUser user) async {
    String retVal = ERROR_FIELD;
    try {

      //await FirebaseFirestore.instance.collection("User").doc(user.uid);
      users.add({
        UID_FIELD: user.uid,
        FULLNAME_FIELD: user.fullName,
        EMAIL_FIELD: user.email,
        'roomName': user.roomName,
        USERNAME_FIELD: user.username,
        STATUS_FIELD: user.status,
        STATE_FIELD: user.state,
        PROFILEPHOTO_FIELD: user.profilePhoto,
      }).then((value) => print("User Added")).catchError((error)=>print("Failed to add new user:$error"));
      retVal = SUCCESS_FIELD;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> updateDetail(String uid, String email, String username,
      String url, String name) async {
    String retval = ERROR_FIELD;
    try {
      await _firestore.collection(USER_COLLECTION).doc(uid).update({
        FULLNAME_FIELD: name,
        EMAIL_FIELD: email,
        USERNAME_FIELD: username,
        PROFILEPHOTO_FIELD: url
      });
      retval = SUCCESS_FIELD;
    } catch (e) {
      retval = ERROR_FIELD;
      print("$e and $retval");
    }
    return retval;
  }

  Future<OurUser> getUserdetail() async {
    User currentUser = _auth.currentUser;
    print("${currentUser.uid} jaypal cheking uid is null or not");

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();
    return OurUser.fromMap(documentSnapshot.data());
  }

  Future<OurUser> getUserDetailById(id) async {
    try {
      print("$id jaypal");
      DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();
      print("$id jaypal1046");
      return OurUser.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection(USER_COLLECTION).doc(uid).get();
      retVal.uid = uid;
      retVal.fullName = _documentSnapshot.get("fullName");
      retVal.email = _documentSnapshot.get(EMAIL_FIELD);
      retVal.username = _documentSnapshot.get(USERNAME_FIELD);
      retVal.status = _documentSnapshot.get(STATUS_FIELD);
      retVal.state = _documentSnapshot.get(STATE_FIELD);
      retVal.roomName = _documentSnapshot.get("roomName");
      retVal.profilePhoto = _documentSnapshot.get(PROFILEPHOTO_FIELD);
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<List<OurUser>> getUserdata(User cureentUser) async {
    List<OurUser> userList = [];
    QuerySnapshot querySnapshot =
        await _firestore.collection(USER_COLLECTION).get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      print(querySnapshot.docs[i].id);
      if (querySnapshot.docs[i].id != cureentUser.uid) {
        print(querySnapshot.docs[i].id);
        // print('jaypal documentID');
        print(OurUser.fromMap(querySnapshot.docs[i].data()));
        userList.add(OurUser.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

  Future<void> addMessagetoDB(
      OurMessage message, OurUser sender, OurUser receiver) async {
    var map = message.toMap();
    await _firestore
        .collection(MESSAGE_COLLECTION)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);
    await addToContact(
        senderId: message.senderId, reciverId: message.receiverId);
    return await _firestore
        .collection(MESSAGE_COLLECTION)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  DocumentReference getContactDocument({String of, String forContact}) =>
      _userCollection.doc(of).collection(CONTACTS_COLLECTION).doc(forContact);

  addToContact({String senderId, String reciverId}) async {
    DateTime currentTime = DateTime.now();

    String returnString =
        await addToSenderConTaxt(senderId, reciverId, currentTime);
    if (returnString == SUCCESS_FIELD) {
      print("contact writen Success full jaypal");
    } else {
      print("you doen locha jaypal");
    }
    String returnString2 =
        await addToReciverConTaxt(senderId, reciverId, currentTime);
    if (returnString2 == SUCCESS_FIELD) {
      print("contact writen Success full ");
    } else {
      print("contact Writen unsucces full ");
    }
  }

  Future<String> addToSenderConTaxt(
      String senderId, String reciverId, currentTime) async {
    String retVal = ERROR_FIELD;
    try {
      DocumentSnapshot sendersnapshot =
          await getContactDocument(of: senderId, forContact: reciverId).get();
      if (!sendersnapshot.exists) {
        //does not Exists
        _userCollection
            .doc(senderId)
            .collection(CONTACTS_COLLECTION)
            .doc("$reciverId")
            .set({
          'Contact_id': reciverId,
          'added_on': currentTime,
        });

        print("yes");
      }
      retVal = SUCCESS_FIELD;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> addToReciverConTaxt(
      String senderId, String reciverId, currentTime) async {
    String retVal = ERROR_FIELD;
    try {
      DocumentSnapshot reciversnapshot =
          await getContactDocument(of: reciverId, forContact: senderId).get();
      if (!reciversnapshot.exists) {
        //does not Exists
        print("yes");
        _userCollection
            .doc(reciverId)
            .collection(CONTACTS_COLLECTION)
            .doc("$senderId")
            .set({
          'Contact_id': senderId,
          'added_on': currentTime,
        });
      }
      retVal = SUCCESS_FIELD;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> uploadImagetodatabase(image) async {
    try {
      _storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}') ;
      final  _storageUploadTask = _storageReference.putFile(image);
      var url = await (await _storageUploadTask.onComplete)
          .ref
          .getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void setImageMsg(String url, String reciverId, String senderId) async {
    OurMessage _message;
    _message = OurMessage.imageMessage(
      message: "Image",
      receiverId: reciverId,
      senderId: senderId,
      photoUrl: url,
      timestamp: Timestamp.now(),
      type: 'image',
    );
    var map = _message.toImageMap();

    await _firestore
        .collection(MESSAGE_COLLECTION)
        .doc(_message.senderId)
        .collection(_message.receiverId)
        .add(map);
    await _firestore
        .collection(MESSAGE_COLLECTION)
        .doc(_message.receiverId)
        .collection(_message.senderId)
        .add(map);
  }

  void uploadImage(image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    imageUploadProvider.setToLoading();
    String url = await uploadImagetodatabase(image);
    imageUploadProvider.setToIdle();
    setImageMsg(url, receiverId, senderId);
  }

  Future<String> updateUserImage(image) async {
    String url = await uploadImagetodatabase(image);

    return url;
  }

  Future<String> createVideoLecture(
      String roomName, String subject, String userId) async {
    String retVal = ERROR_FIELD;
    List<String> member = [];

    try {
      member.add(userId);
      await _firestore.collection("VideoLecture").doc(roomName).set({
        'lectureName': subject,
        'creatorUid': userId,
        'roomName': roomName,
        'member': member,
        'lectureCreated': DateTime.now(),
      });

      await _firestore.collection("User").doc(userId).update({
        'roomName': roomName,
      });

      retVal = SUCCESS_FIELD;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> joinVideolecture(
      String roomName, String subject, String userId) async {
    String retVal = ERROR_FIELD;
    List<String> member = [];

    try {
      member.add(userId);

      await _firestore
          .collection("VideoLecture")
          .doc(roomName)
          .update({'member': member});

      retVal = SUCCESS_FIELD;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Stream<QuerySnapshot> fetchContact({String userId}) {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(userId)
        .collection(CONTACTS_COLLECTION)
        .snapshots();
    return stream;
  }

  Stream<QuerySnapshot> fatchLastMessageBetween(
          {@required String senderId, @required String reciverId}) =>
      _firestore
          .collection(MESSAGE_COLLECTION)
          .doc(senderId)
          .collection(reciverId)
          .orderBy("timestamp")
          .snapshots();

  void setUserState(
      {@required String userId, @required OurUserState userState}) {
    int statenum = OurUsername.stateToNum(userState);
    _userCollection.doc(userId).update({
      'state': statenum,
    });
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.doc(uid).snapshots();
}
