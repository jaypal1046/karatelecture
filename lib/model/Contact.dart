import 'package:cloud_firestore/cloud_firestore.dart';

class OurContact{
  String Contact_id;
  Timestamp added_on;
  OurContact({this.Contact_id,this.added_on});

  Map toMap(OurContact contact){
    var data=Map<String,dynamic>();
    data['Contact_id']=contact.Contact_id;
    data['added_on']=contact.added_on;
    return data;
  }
  OurContact.fromMap(Map<String,dynamic>mapData){
    this.Contact_id=mapData['Contact_id'];
    this.added_on=mapData['added_on'];
  }


}