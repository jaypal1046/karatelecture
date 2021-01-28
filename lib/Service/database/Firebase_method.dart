import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karate_lecture/Util/username.dart';
import 'package:karate_lecture/model/user.dart';

class FirebaseMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  OurUser users = OurUser();

  Future<User> getCurrentUser() async {
    User current = _auth.currentUser;
    return current;
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount _signAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken,
    );
    UserCredential user = await _auth.signInWithCredential(credential);
    return user;
  }

  Future<bool> authenticationuser(UserCredential credential) async {
    QuerySnapshot querySnapshot = await firestore
        .collection("users")
        .where("email", isEqualTo: credential.user.email)
        .get();
    final List<DocumentSnapshot> doc = querySnapshot.docs;
    return doc.length == 0 ? true : false;
  }

  Future<void> addDataToDb(UserCredential credential) async {
    String username = OurUsername.getUsername(credential.user.email);
    print("jaypal $username");
    users = OurUser(
      uid: credential.user.uid,
      email: credential.user.email,
      fullName: credential.user.displayName,
      profilePhoto: credential.user.photoURL,
      username: username,
    );

    firestore
        .collection("users")
        .doc(credential.user.uid)
        .set(users.toMap(users));
  }

  Future<List<OurUser>> getUserdata(UserCredential cureentUser) async {
    List<OurUser> userList = [];
    QuerySnapshot querySnapshot = await firestore.collection("User").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != cureentUser.user.uid) {
        userList.add(OurUser.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }
}
