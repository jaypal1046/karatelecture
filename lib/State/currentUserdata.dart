import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karate_lecture/Constaint/string_Const.dart';
import 'package:karate_lecture/Service/database/database.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/model/user.dart';
class CurrentState extends ChangeNotifier{
  OurUser _currentUser=OurUser();
  OurUser get getCurrentUser  =>_currentUser;
  FirebaseAuth _auth=FirebaseAuth.instance;

  Future<String> OnStartup() async
  {
    String retval=ERROR_FIELD;
    try{
      User _firebaseUser= await _auth.currentUser;
     // _currentUser.uid=_firebaseUser.uid;
     // _currentUser.email=_firebaseUser.email;

     // retval="Success";
      _currentUser= await OurDatabase().getUserInfo(_firebaseUser.uid);
      if(_currentUser!=null){
        retval=SUCCESS_FIELD;
      }
    }catch(e){
      print(e);
    }
    return retval;
  }

  Future<String> SignOut() async
  {
    String retval=ERROR_FIELD;
    try{
      await _auth.signOut();
      _currentUser=OurUser();
      retval=SUCCESS_FIELD;
    }catch(e){
      print(e);
    }
    return retval;
  }
  Future<String> signUpUser(String email,String password,String fullName) async{
    String retval=ERROR_FIELD;
    OurUser _ourUser=OurUser();
    try{
      UserCredential _authResult= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String username=await OurUsername.getUsername(_authResult.user.email);
      _ourUser.uid=_authResult.user.uid;
      _ourUser.email=_authResult.user.email;
      _ourUser.fullName=fullName;
      if(_authResult.user.photoURL==null){
        _ourUser.profilePhoto="https://www.iconfinder.com/icons/2024644/download/png/512";
      }

      _ourUser.username=username;
      print("jay cjeck uoser email name $username");
      String _returnString=await OurDatabase().createUser(_ourUser);
      if(_returnString==SUCCESS_FIELD){
        retval=SUCCESS_FIELD;
      }
    }catch(e){
      retval=e.message;
    }
    return retval;
  }

  Future<String> logInUserwithEmail( String email,String password ) async{
    String retval=ERROR_FIELD;
    try{
      UserCredential _authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);

       // _currentUser.uid=_authResult.user.uid;
       // _currentUser.email=_authResult.user.email;
      // retval="success";
      _currentUser= await OurDatabase().getUserInfo(_authResult.user.uid);
      if(_currentUser!=null){
        retval=SUCCESS_FIELD;
      }

    }catch(e){
      retval=e.message;
    }
    return retval;
  }

  Future<String> logInUserWithGoogle() async {
    String retval=ERROR_FIELD;
    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      OurUser _user=OurUser();
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;
      String username=OurUsername.getUsername(authResult.user.email);

      if (user != null) {
        assert(user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
        assert(user.email != null);
        assert(user.displayName != null);
        assert(user.photoURL != null);

        print('signInWithGoogle succeeded: $user');
       /* name = user.displayName;
        email = user.email;
        imageUrl = user.photoURL;
        print(name);
        print(email);
        print(imageUrl);*/
    if(user.isAnonymous){
      _user.uid=authResult.user.uid;
      _user.email=authResult.user.email;
      _user.fullName=authResult.user.displayName;


      _user.username=username;
      print("jay cjeck uoser name $username");
      if(authResult.user.photoURL==null){
        _user.profilePhoto=Icon(Icons.insert_emoticon) as String;
      }else {
        _user.profilePhoto = authResult.user.photoURL;
      }
      print("${_user.username}");
      print("${_user.email}");
      print("${_user.fullName}");
      print("JAYPAL---1046");

      OurDatabase().createUser(_user);
    }


       /* if (name.contains(" ")) {
          name = name.substring(0, name.indexOf(" "));
        }
        Database().createUser(_user);*/

        return '$user';
      }
      _currentUser= await OurDatabase().getUserInfo(authResult.user.uid);
      if(_currentUser!=null){
        retval=SUCCESS_FIELD;
      }
    }catch(e){
      print("error");
      print(e);
    }

    return retval;
  }

  /*Future<String> logInUserWithGoogle( ) async{
    String retval=ERROR_FIELD;

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    OurUser _user=OurUser();



    try{
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential _authResult = await _auth.signInWithCredential(credential);
      String username=OurUsername.getUsername(_authResult.user.email);
        final User user = _authResult.user;
      if(user.isAnonymous)
        {

          _user.uid=_authResult.user.uid;
          _user.email=_authResult.user.email;
          _user.fullName=_authResult.user.displayName;


          _user.username=username;
          print("jay cjeck uoser name $username");
          if(_authResult.user.photoURL==null){
            _user.profilePhoto=Icon(Icons.insert_emoticon) as String;
          }else {
            _user.profilePhoto = _authResult.user.photoURL;
          }
          print("${_user.username}");
          print("${_user.email}");
          print("${_user.fullName}");
          print("JAYPAL---1046");

          OurDatabase().createUser(_user);
        }
     // _currentUser.uid=_authResult.user.uid;
     // _currentUser.email=_authResult.user.email;

     _currentUser= await OurDatabase().getUserInfo(_authResult.user.uid);
      if(_currentUser!=null){
        retval=SUCCESS_FIELD;
      }
    }on PlatformException catch(e){
      retval=e.message;
    }catch(e){
      print(e);
    }
    return retval;
  }*/
}