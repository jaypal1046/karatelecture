import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:karate_lecture/Service/LocalDB/Repo/Repo.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/State/getUseruid.dart';
import 'package:karate_lecture/enum/User_state.dart';
import 'package:karate_lecture/home/ChatListScreen/OurChatList.dart';
import 'package:karate_lecture/home/Profile_Setting/ProfileSetting.dart';
import 'package:karate_lecture/home/VideosPlay/ChannalView.dart';
import 'package:karate_lecture/home/groupVideo/groupLecturehome.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController pageController;
  int _page = 0;
  UserProvider _provider;
  CurrentState provider;
  String uid;
  OurDatabase database = OurDatabase();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _provider = Provider.of<UserProvider>(context, listen: false);
      provider = Provider.of<CurrentState>(context, listen: false);
      uid = provider.getCurrentUser.uid;

      await _provider.refreshUser();
      print(_provider.getUser.uid);
      print("jaypal uid check");
      database.setUserState(
          userId: _provider.getUser.uid, userState: OurUserState.Online);
    });
    WidgetsBinding.instance.addObserver(this);
    pageController = PageController();
   /* LogRepository.init(
      isHive: false,
      dbName: uid,
    );*/
//localNotifyManager.setOnNotificationRecive(onNotificationReciver);
//localNotifyManager.setOnNotficationClick(onNotificationClick);
  }
/*  onNotificationReciver(ReciveNotification notification){
    print("Notification reciver ${notification.id}");
  }
  onNotificationClick(String payload){
    print('Payload $payload');
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentuser = (_provider != null && _provider.getUser != null)
        ? _provider.getUser.uid
        : "";
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        currentuser != null
            ? database.setUserState(
                userId: currentuser, userState: OurUserState.Online)
            : print("resumed state");
        break;

      case AppLifecycleState.inactive:
        currentuser != null
            ? database.setUserState(
                userId: currentuser, userState: OurUserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentuser != null
            ? database.setUserState(
                userId: currentuser, userState: OurUserState.Waiting)
            : print("Paused state");

        break;
      case AppLifecycleState.detached:
        currentuser != null
            ? database.setUserState(
                userId: currentuser, userState: OurUserState.Offline)
            : print("detached state");
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBarItem = BottomNavigationBarItem(
      icon: Icon(
        Icons.chat,
        color: (_page == 0) ? Colors.lightBlueAccent : Colors.black87,
      ),
      // ignore: deprecated_member_use
      title: Text(
        "Chat",
        style: TextStyle(
          fontSize: 10,
          color: (_page == 0) ? Colors.lightBlueAccent : Colors.black87,
        ),
      ),
    );
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Container(
            child: OurChatList(),
          ),
          Center(
            child: OurGroupLectureHome(),
          ),
          Center(
            child: OurAllChannalList(),
          ),
          Center(child: OurProfileSetting()),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
            backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              bottomNavigationBarItem,
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_call,
                    color:
                        (_page == 1) ? Colors.lightBlueAccent : Colors.black87,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "call",
                    style: TextStyle(
                      fontSize: 10,
                      color: (_page == 1)
                          ? Colors.lightBlueAccent
                          : Colors.black87,
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color:
                        (_page == 2) ? Colors.lightBlueAccent : Colors.black87,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "home",
                    style: TextStyle(
                      fontSize: 10,
                      color: (_page == 2)
                          ? Colors.lightBlueAccent
                          : Colors.black87,
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color:
                        (_page == 3) ? Colors.lightBlueAccent : Colors.black87,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Setting",
                    style: TextStyle(
                      fontSize: 10,
                      color: (_page == 3)
                          ? Colors.lightBlueAccent
                          : Colors.black87,
                    ),
                  )),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}
