import 'package:cloud_firestore/cloud_firestore.dart';

class OurVideoChannel{
  String channelId;
  String ChannelAddedBy;
  Timestamp ChannelAddOn;

  OurVideoChannel({this.channelId,this.ChannelAddedBy,this.ChannelAddOn});



  Map toMap(OurVideoChannel contact){
    var data=Map<String,dynamic>();
    data['channelId']=contact.channelId;
    data['ChannelAddedBy']=contact.ChannelAddedBy;
    data['channelAdded']=contact.ChannelAddOn;
return data;
  }
  OurVideoChannel.fromMap(Map<String,dynamic>mapData){
    this.channelId=mapData['channelId'];
    this.ChannelAddedBy=mapData['ChannelAddedBy'];
    this.ChannelAddOn=mapData['channelAdded'];
  }

}