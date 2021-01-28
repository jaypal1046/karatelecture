import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Service/ApiService/ApiService.dart';
import 'package:karate_lecture/Service/database/firebase_repo.dart';
import 'package:karate_lecture/Widget/OurAppBar.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/home/VideosPlay/VideoPlay.dart';
import 'package:karate_lecture/home/VideosPlay/Widget/AddNewChannel.dart';
import 'package:karate_lecture/model/channal.dart';

class OurAllChannalList extends StatefulWidget {
  @override
  _OurAllChannalListState createState() => _OurAllChannalListState();
}

class _OurAllChannalListState extends State<OurAllChannalList> {
  FirebaseRepo repo = FirebaseRepo();
  List<String> userList = [];
  //List<String> userList2=new List<String>();
  // List<String> userList3=new List<String>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Channel channel;
  List<Channel> _channel;
  //bool _isLoading =false;
  @override
  void initState() {
    super.initState();
    getChannelData();
  }

  void getChannelData() async {
    final credencal = _firestore.collection(VIDEOCHANNEL_COLLECTION);
    await credencal.get().then((snapshot) => {
          snapshot.docs.forEach((doc) {
            userList.add(doc.id);
          })
        });
    // await print(userList[0]);
    //await print(userList[1]);
    //await print('jay');
    await _initChannelList(userList);
    // await print('1046 love');
  }

  _initChannelList(List<String> userList) async {
    // List<String>  _channel= await repo.getChanneldata();

    print(userList.length);
    //  print('jay jay jay');
    //channel=await APIService.instance.
    //  fetchChannel(channelId: userList[0]);
    /*Channel channel1=await APIService.instance.
    fetchChannel(channelId: 'UC6Dy0rQ6zDnQuHQ1EeErGUA');*/
    _channel = [];
    for (var i = 0; i < userList.length; i++) {
      channel = await APIService.instance.fetchChannel(channelId: userList[i]);
      if (mounted) {
        setState(() {
          _channel.add(channel);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    getChannelData();
  }

  OurAppBar customeAppBar(BuildContext context) {
    return OurAppBar(
      title: OurContener(
        child: Text('channel'),
      ),
      centerTitle: true,
      action: <Widget>[
        FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddNewChannel(),
                )),
          },
          tooltip: 'Add a Channel Id',
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customeAppBar(context),
        body: Column(
          children: <Widget>[
            _channel != null
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _channel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _builderProfileInfo(index);
                        }),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ));
  }

  _builderProfileInfo(int index) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OurVideoScreen(
                channel: _channel[index],
              ),
            )),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: OurContener(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    backgroundImage:
                        NetworkImage(_channel[index].profilePictureUrl),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _channel[index].title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${_channel[index].subscriberCount} Subscription',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
