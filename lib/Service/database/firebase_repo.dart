import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:karate_lecture/Service/database/Firebase_method.dart';
import 'package:karate_lecture/Service/database/Video_database.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/OurImageProvider.dart';
import 'package:karate_lecture/model/massage.dart';
import 'package:karate_lecture/model/user.dart';

class FirebaseRepo {
  FirebaseMethod firebaseMethod = FirebaseMethod();
  OurDatabase databse = OurDatabase();

  OurVideoDatabase videoDatabase = OurVideoDatabase();

  Future<User> getCurrentuser() => firebaseMethod.getCurrentUser();

  Future<UserCredential> signIn() => firebaseMethod.signIn();

  Future<bool> authenticationuser(UserCredential credential) =>
      firebaseMethod.authenticationuser(credential);

  Future<void> addDataToDb(UserCredential credential) =>
      firebaseMethod.addDataToDb(credential);

  Future<List<OurUser>> getUserdata(User user) => databse.getUserdata(user);

  Future<String> createChannel(String channelId, userId) =>
      videoDatabase.createChannel(channelId, userId);

  Future<List<String>> getChanneldata() => videoDatabase.getChanneldata();

  Future<OurUser> getUserDetails() => databse.getUserdetail();

  Future<void> addMessagetoDb(
          OurMessage message, OurUser sender, OurUser receiver) =>
      databse.addMessagetoDB(message, sender, receiver);
  void uploadImage(
          {@required File image,
          @required String receiverId,
          @required String senderId,
          @required ImageUploadProvider imageProvider}) =>
      databse.uploadImage(
        image,
        receiverId,
        senderId,
        imageProvider,
      );
}
