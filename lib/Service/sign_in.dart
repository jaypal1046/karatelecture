import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karate_lecture/Service/Database.dart';
import 'package:karate_lecture/Service/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;
Future <String >signInWithEmail()async{

}
Future<String> signInWithGoogle() async {
try{
  OurUser _user=OurUser();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    print('signInWithGoogle succeeded: $user');
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    print(name);
    print(email);
    print(imageUrl);
    _user.uid=user.uid;
    _user.email=user.email;
    _user.fullName=user.displayName;


    _user.username="";

    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }
    Database().createUser(_user);

    return '$user';
  }

}catch(e){
  print("error");
  print(e);
}

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}