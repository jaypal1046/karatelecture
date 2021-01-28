import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';

class OurVideoDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createChannel(String channelId, String userId) async {
    String retVal = ERROR_FIELD;
    try {
      await _firestore.collection(VIDEOCHANNEL_COLLECTION).doc(channelId).set({
        'ChannelId': channelId,
        'ChannelAddedBy': userId,
        'ChannelAddOn': Timestamp.now(),
      });

      retVal = SUCCESS_FIELD;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<List<String>> getChanneldata() async {
    List<String> userList = [];
    final stringq = _firestore.collection(VIDEOCHANNEL_COLLECTION);
    stringq.get().then((snapshot) => {
          snapshot.docs.forEach((doc) {
            userList.add(doc.id);
            print(userList);
            print('1046 love i dont ');
          })
        });
    return userList;
  }
}
