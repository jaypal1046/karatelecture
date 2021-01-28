import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/model/call.dart';

class OurCallMethod {
  final collectionReference =
      FirebaseFirestore.instance.collection(Call_COLLECTION);
  Stream<DocumentSnapshot> callStreem({String uid}) =>
      collectionReference.doc(uid).snapshots();
  Future<bool> makeCall({OurCall call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDiallesdMap = call.toMap(call);
      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);
      await collectionReference
          .doc(call.callerId)
          .collection(call.channelId)
          .add(hasDiallesdMap);
      await collectionReference
          .doc(call.receiverId)
          .collection(call.channelId)
          .add(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<bool> endCall({OurCall call}) async {
    try {
      await collectionReference.doc(call.callerId).delete();
      await collectionReference.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
