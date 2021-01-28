import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:karate_lecture/enum/User_state.dart';
import 'package:path_provider/path_provider.dart';

class OurUsername {
  static String getUsername(String email) {
    return "${email.split("@")[0]}";
  }

  static String getinitials(String name) {
    List<String> nameSplite = name.split(" ");
    String firstNameinitials = nameSplite[0][0];
    String lastNameinitials = nameSplite[1][0];
    return firstNameinitials + lastNameinitials;
  }

  static Future<File> pickImage(@required ImageSource source) async {
    // ignore: deprecated_member_use
    File selectImage = await ImagePicker.pickImage(source: source);
    return selectImage;
  }

  /* static Future<File> compressImage(File imageToCompress)async{
    final tenpDir=await getTemporaryDirectory();
    final path=tenpDir.path;
    int random=Random().nextInt(1000);

    IM.Image image=await IM.decodeImage((imageToCompress.readAsBytesSync()));
    IM.copyResize(image,width: 500,height: 500);
    return new File("$path/img_$random.jpg")..writeAsBytesSync(IM.encodeJpg(image,quality: 85));

  }*/
  static int stateToNum(OurUserState userState) {
    switch (userState) {
      case OurUserState.Offline:
        return 0;
      case OurUserState.Online:
        return 1;
      default:
        return 2;
    }
  }

  static OurUserState numtoStaet(int num) {
    switch (num) {
      case 0:
        return OurUserState.Offline;
      case 1:
        return OurUserState.Online;
      default:
        return OurUserState.Waiting;
    }
  }

  static String formatDateString(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    var formatter = DateFormat('dd/MM/yy  hh:mm:ss');
    return formatter.format(dateTime);
  }
}
