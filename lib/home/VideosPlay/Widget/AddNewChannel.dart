import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Screen/HelpScreen/OurHelpScreen.dart';
import 'package:karate_lecture/Service/ApiService/ApiService.dart';
import 'package:karate_lecture/Service/database/firebase_repo.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/model/channal.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddNewChannel extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: OurContener(
            child: Text('Add Channel'),
          ),
        ),
        body: SingleChildScrollView(
          child: OurContener(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      prefix: Icon(Icons.video_library), hintText: 'ChannelId'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                    height: 40.0,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OurHelpScreen(),
                                )),
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'how to get channel-Id',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(
                                Icons.help_outline,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ))),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () =>
                      ChannelIdValidation(context, _emailController.text),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
ChannelIdValidation(BuildContext context, String channelId) async {
  FirebaseRepo repo = new FirebaseRepo();
  CurrentState currentState = Provider.of<CurrentState>(context, listen: false);
  try {
    Channel channel =
        await APIService.instance.fetchChannel(channelId: channelId);
    if (channel.videos.isNotEmpty) {
      String returnString =
          await repo.createChannel(channelId, currentState.getCurrentUser.uid);
      if (returnString == SUCCESS_FIELD) {
        Navigator.pop(context);
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(returnString),
          duration: Duration(seconds: 10),
        ));
      }
    }
  } catch (e) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(e),
      duration: Duration(seconds: 10),
    ));
  }
}
