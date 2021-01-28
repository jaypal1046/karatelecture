import 'package:flutter/material.dart';

import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/State/getUseruid.dart';
import 'package:karate_lecture/Widget/OurAppBar.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/enum/User_state.dart';
import 'package:karate_lecture/home/Profile_Setting/Widget/MoreVar_Option.dart';
import 'package:karate_lecture/home/Profile_Setting/Widget/OurEditeProfile.dart';
import 'package:karate_lecture/root/root.dart';
import 'package:provider/provider.dart';

class OurProfileSetting extends StatefulWidget {
  @override
  _OurProfileSettingState createState() => _OurProfileSettingState();
}

class _OurProfileSettingState extends State<OurProfileSetting> {
  UserProvider _provider;
  OurDatabase database;
  @override
  void initState() {
    super.initState();
    _provider = Provider.of<UserProvider>(context, listen: false);
    database = OurDatabase();
  }

  OurAppBar customeAppBar(BuildContext context, String username) {
    return OurAppBar(
      title: OurContener(
        child: Text(username),
      ),
      centerTitle: true,
      action: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5),
        ),
        PopupMenuButton<String>(
          onSelected: choisesAction,
          itemBuilder: (BuildContext context) {
            return OurConstrain.choices.map((String choices) {
              return PopupMenuItem<String>(
                value: choices,
                child: Text(choices),
              );
            }).toList();
          },
        )
      ],
    );
  }

  void choisesAction(String choises) {
    if (choises == OurConstrain.profile) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return OurProfileSetting();
      }));
    }
    if (choises == OurConstrain.Editprofile) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return OurEditProfile();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _currentUse =
        Provider.of<CurrentState>(context, listen: false);
    //UserProvider _provider=Provider.of<UserProvider>(context,listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customeAppBar(context, _currentUse.getCurrentUser.username),
      body: profile(_currentUse),
    );
  }

  Widget profile(CurrentState _currentUse) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: OurContener(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_provider.getUser.profilePhoto),
                  backgroundColor: Colors.grey,
                  radius: 45,
                ),
              ),
              Divider(
                color: Colors.black87,
                height: 60.0,
              ),
              Text(
                "NAME",
                style: TextStyle(
                  color: Colors.black87,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                _currentUse.getCurrentUser.fullName,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "USERNAME",
                style: TextStyle(
                  color: Colors.black87,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                _currentUse.getCurrentUser.username,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        child: RichText(
                          text: TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                              children: <TextSpan>[
                                new TextSpan(text: 'EMAIL \n'),
                                new TextSpan(
                                  text: _currentUse.getCurrentUser.email,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: RaisedButton(
                  child: Text('SignOut'),
                  onPressed: () => _signOut(context),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    CurrentState _currentState =
        Provider.of<CurrentState>(context, listen: false);
    await _provider.refreshUser();
    print(_provider.getUser.uid);
    print("jaypal uid check");
    database.setUserState(
        userId: _provider.getUser.uid, userState: OurUserState.Offline);

    String _returnString = await _currentState.SignOut();
    if (_returnString == SUCCESS_FIELD) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }
}
