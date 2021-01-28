/*class OurGroupVideoLecture{
  final Firestore _firestore=Firestore.instance;

  Future<String> createLecture(String lectureid,String uid,OurVideoLecture ourVideoLecture)async{
    List<String> member=List();
  String retval=ERROR_FIELD;
  try{
    member.add(uid);
    await _firestore.collection("VideoLecture").add({
      "lectureUid":lectureUid,
      "lectureName": ourVideoLecture.lectureName,
      "member": ourVideoLecture.member,

      "roomName":ourVideoLecture.roomName,
      "creatorUid": ourVideoLecture.creatorUid,

    });
    retval =SUCCESS_FIELD;
  }catch(e){
    print(e);
  }
  return retval;
  }
}*/
