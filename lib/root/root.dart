import 'package:flutter/material.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/SearchScreen/SearchScreen.dart';
import 'package:karate_lecture/Service/login/login.dart';
import 'package:karate_lecture/SpaceScreen/SpaceScreen.dart';

import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/home/home.dart';

import 'package:provider/provider.dart';
enum AuthState{
  unknown,
  notLoggedIn,
  isLoggedIn,
  inGroup,
}
class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authState=AuthState.unknown;


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //getState,checkState,set AuthSate base on state
    CurrentState _currentUse=Provider.of<CurrentState>(context,listen: false);
   String returnString=await _currentUse.OnStartup();


   if(returnString==SUCCESS_FIELD){
      if(_currentUse.getCurrentUser.uid ==null){
        setState(() {
          _authState = AuthState.notLoggedIn;
        });
      }else {
        setState(() {
          _authState = AuthState.isLoggedIn;
        });
      }

    }else{
      setState(() {
        _authState = AuthState.notLoggedIn;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch(_authState){
      case AuthState.unknown:
        retVal=OurSpaceScreen();
        break;
      case AuthState.notLoggedIn:
        retVal=OurLogin();
        break;
      case AuthState.isLoggedIn:
        retVal=HomeScreen();
        break;
      case AuthState.inGroup:
        //retVal=ChangeNotifierProvider(create: (context)=>CurrentGroupState(), child: HomeScreen(),);
        break;
      default:
    }
    return retVal;
  }
}
