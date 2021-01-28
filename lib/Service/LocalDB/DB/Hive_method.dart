/*import 'dart:io';

import 'package:hive/hive.dart';
import 'package:jay_books/Service/LocalDB/Interface/InterFace.dart';
import 'package:jay_books/model/Log.dart';
import 'package:path_provider/path_provider.dart';

class HiveMethods implements LogInterface {
  var hiveBox = "";

  @override
  openDb(dbName) => (hiveBox = dbName);

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path + "$hiveBox.db");
  }

  Future<int> addLogs(Log log) async {
    var box = await Hive.openBox(hiveBox);

    var logMap = log.toMap(log);

    // box.put("custom_key", logMap);
    int idOfInput = await box.add(logMap);

    print("Log added with id ${idOfInput.toString()} in Hive db");

    close();

    return idOfInput;
  }

  updateLogs(int i, Log newLog) async {
    var box = await Hive.openBox(hiveBox);

    var newLogMap = newLog.toMap(newLog);

    box.putAt(i, newLogMap);

    close();
  }

  Future<List<Log>> getLogs() async {
    var box = await Hive.openBox(hiveBox);

    List<Log> logList = [];

    for (int i = 0; i < box.length; i++) {
      var logMap = box.getAt(i);

      logList.add(Log.fromMap(logMap));
    }
    return logList;
  }

  @override
  deleteLogs(int logId) async {
    var box = await Hive.openBox(hiveBox);

    await box.deleteAt(logId);
    // await box.delete(logId);
  }

  @override
  close() => Hive.close();
}
*/