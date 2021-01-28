/*import 'dart:io';

import 'package:jay_books/Service/LocalDB/Interface/InterFace.dart';
import 'package:jay_books/model/Log.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteMethods implements LogInterface {
  Database _db;

  String databaseName;

  String tableName = "Call_Logs";

  // columns
  String id = 'log_id';
  String callerName = 'caller_Username';
  String callerPic = 'caller_pic';
  String receiverName = 'receiver_Username';
  String receiverPic = 'receiver_pic';
  String callStatus = 'call_status';
  String timestamp = 'timestamp';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print("db was null, now awaiting it");
    _db = await init();
    return _db;
  }

  @override
  openDb(dbName) => (databaseName = dbName);

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    print("dir jaypal");
    print(dir.path);

    String databaseNames = "$databaseName.db";
    String path = join(dir.path, databaseNames);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $callerName TEXT, $callerPic TEXT, $receiverName TEXT, $receiverPic TEXT, $callStatus TEXT, $timestamp TEXT)";

    await db.execute(createTableQuery);
    print("table created");
  }

  addLogs(Log log) async {
    var dbClient = await db;
    print("the log has been added in sqlite db");
    await dbClient.insert(tableName, log.toMap(log));
  }

  updateLogs(Log log) async {
    var dbClient = await db;

    await dbClient.update(
      tableName,
      log.toMap(log),
      where: '$id = ?',
      whereArgs: [log.logId],
    );
  }

  Future<List<Log>> getLogs() async {
    try {
      var dbClient = await db;

      // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $tableName");
      List<Map> maps = await dbClient.query(
        tableName,
        columns: [
          id,
          callerName,
          callerPic,
          receiverName,
          receiverPic,
          callStatus,
          timestamp,
        ],
      );

      List<Log> logList = [];

      if (maps.isNotEmpty) {
        for (Map map in maps) {
          logList.add(Log.fromMap(map));
        }
      }

      return logList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  deleteLogs(int logId) async {
    var client = await db;
    return await client.delete(tableName, where: '$id = ?', whereArgs: [logId]);
  }

  @override
  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
*/