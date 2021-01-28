import 'package:flutter/cupertino.dart';
import 'package:karate_lecture/Service/database/firebase_repo.dart';

import 'package:karate_lecture/model/user.dart';

class UserProvider with ChangeNotifier {
  OurUser _user;
  FirebaseRepo _repo = FirebaseRepo();
  OurUser get getUser => _user;

  Future<void> refreshUser() async {
    OurUser user = await _repo.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
