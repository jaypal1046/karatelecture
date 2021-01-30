import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:karate_lecture/Screen/login.dart';
import 'package:provider/provider.dart';
import 'package:karate_lecture/Service/block_auth.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<User> loginStateSubcription;

  @override
  void initState() {

    var authblock=Provider.of<AuthBlock>(context,listen: false);
    loginStateSubcription=authblock.currentUser.listen((GUser) {
      if(GUser ==null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    });
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
    loginStateSubcription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc=Provider.of<AuthBlock>(context);
    return Scaffold(
      body: Center(
        child: StreamBuilder<User>(
          stream: authBloc.currentUser,
          builder: (context,snapshot){
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data.displayName),
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data.photoURL.replaceFirst('s96','s400')),
                  radius: 60.0,
                ),
                SignInButton(Buttons.Google,
                  text: "Sign out with google", onPressed: ()=>authBloc.logout()
                  ,)
              ],
            );
          },
        )
      )
    );
  }
}
