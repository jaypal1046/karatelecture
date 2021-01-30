import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:karate_lecture/Screen/home.dart';
import 'package:karate_lecture/Service/block_auth.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription<User> loginStateSubcription;
  @override
  Widget build(BuildContext context) {
    final authBloc=Provider.of<AuthBlock>(context,listen: false);
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google,
              onPressed: ()=> authBloc.loginGoogle()
               //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen())),
            )
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    var authblock=Provider.of<AuthBlock>(context,listen: false);
    loginStateSubcription=authblock.currentUser.listen((GUser) {
      if(GUser !=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    });
    super.initState();

  }
  @override
  void dispose() {
 loginStateSubcription.cancel();
    super.dispose();
  }
}
