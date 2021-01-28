/*import 'package:flutter/cupertino.dart';

import 'package:jay_books/Service/LocalDB/DB/Hive_method.dart';
import 'package:jay_books/Service/LocalDB/DB/sql.dart';
import 'package:jay_books/model/Log.dart';

class LogRepository {
  static var dbObject;
  static bool isHive;

  static init({@required bool isHive, @required String dbName}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.openDb(dbName);
    dbObject.init();
  }

  static addLogs(Log log) => dbObject.addLogs(log);

  static deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static getLogs() => dbObject.getLogs();

  static close() => dbObject.close();
}



 */