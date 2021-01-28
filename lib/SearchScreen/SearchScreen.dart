import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:karate_lecture/Screen/ChatScreen/ChatScreen.dart';
import 'package:karate_lecture/Screen/callScreen/PickUp/PickupLayout.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/Service/database/firebase_repo.dart';

import 'package:karate_lecture/Util/UniversalVariable.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/Widget/OurCustomTitle.dart';
import 'package:karate_lecture/model/user.dart';

class OurSearchScreen extends StatefulWidget {
  @override
  _OurSearchScreenState createState() => _OurSearchScreenState();
}

class _OurSearchScreenState extends State<OurSearchScreen> {
  OurDatabase database = OurDatabase();
  FirebaseRepo _repo = FirebaseRepo();
  List<OurUser> userList;
  String query = "";
  TextEditingController serachController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repo.getCurrentuser().then((User user) {
      _repo.getUserdata(user).then((List<OurUser> list) {
        userList = list;
        print(list);
      });
    });
  }

  searchAppBar(BuildContext context) {
    return GradientAppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context)),
      elevation: 0,
      bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: TextFormField(
              controller: serachController,
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
              cursorColor: UniversalVrialbes.blackColor,
              autofocus: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 25,
              ),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => serachController.clear());
                      serachController.clear();
                      query = "";
                    },
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black87,
                  )),
            ),
          ),
          preferredSize: const Size.fromHeight(kToolbarHeight + 20)),
    );
  }

  buildSuggestion(String query) {
    final List<OurUser> suggestionList = query.isEmpty
        ? []
        : userList.where((OurUser user)
            //    (user.username.toLowerCase().contains(query.toLowerCase())||(user.name.toLowerCase().contains(query.toLowerCase())))).toList();
            {
            String _getUsername = user.username;
            String _getgemail = user.email;
            print(_getUsername);
            print(user.username);
            String _query = query;
            print(_query);
            // String _getName=user.name;
            // print(_getName);
            bool matchesUsername = _getUsername.contains(_query);
            bool matchesEmail = _getgemail.contains(_query);
            print(matchesUsername);
            // bool matchesName=_getName.contains(_query);
            // print(matchesName);
            print(matchesUsername);
            if (matchesEmail && matchesUsername) {
              return matchesUsername;
            }
            return (matchesUsername || matchesEmail);
            //(user.username.toLowerCase().contains(query.toLowerCase())||(user.name.toLowerCase().contains(query.toLowerCase()))))
          }).toList();

    return ListView.builder(
      itemBuilder: ((context, index) {
        OurUser searchedUser = OurUser(
          uid: suggestionList[index].uid,
          profilePhoto: suggestionList[index].profilePhoto,
          email: suggestionList[index].email,
          username: suggestionList[index].username,
        );
        return OurContener(
          child: OurCustomTitle(
              mini: false,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OurChatScreen(receiver: searchedUser)));
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(searchedUser.profilePhoto),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                searchedUser.username,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                searchedUser.email,
                style: TextStyle(
                  color: UniversalVrialbes.grayColor,
                ),
              )),
        );
      }),
      //itemCount: 50,
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchAppBar(context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: buildSuggestion(query),
        ),
    );
  }
}
