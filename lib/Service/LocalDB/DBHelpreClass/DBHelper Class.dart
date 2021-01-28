/*import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OurLocalDBHelper {
  String databaseName;
  int _dbVersion = 1;
  String tableName = "Call_Logs";

  // columns
  String id = 'log_id';
  String callerName = 'caller_Username';
  String callerPic = 'caller_pic';
  String receiverName = 'receiver_Username';
  String receiverPic = 'receiver_pic';
  String callStatus = 'call_status';
  String timestamp = 'timestamp';

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print("db was null, now awaiting it");
    _db = await init();
    return _db;
  }

  init() async {
    Directory directry = await getApplicationDocumentsDirectory();
    String path = join(directry.path, databaseName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<dynamic> _onCreate(Database db, int version) async {}

  OurLocalDBHelper._privateConstracter();
  static final OurLocalDBHelper instance =
      OurLocalDBHelper._privateConstracter();
}
*/