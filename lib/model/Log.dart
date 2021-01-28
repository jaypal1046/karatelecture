class Log {
  int logId;
  String callerUsername;
  String callerPic;
  String receiverUsername;
  bool callMedebyCaller;
  String receiverPic;
  String callStatus;
  String timestamp;

  Log({
    this.logId,
    this.callerUsername,
    this.callerPic,
    this.receiverUsername,
    this.receiverPic,
    this.callStatus,
    this.timestamp,
  });

  // to map
  Map<String, dynamic> toMap(Log log) {
    Map<String, dynamic> logMap = Map();
    logMap["log_id"] = log.logId;
    logMap["caller_Username"] = log.callerUsername;
    logMap["caller_pic"] = log.callerPic;
    logMap["receiver_Username"] = log.receiverUsername;
    logMap["receiver_pic"] = log.receiverPic;
    logMap["call_status"] = log.callStatus;
    logMap["timestamp"] = log.timestamp;
    return logMap;
  }

  Log.fromMap(Map logMap) {
    this.logId = logMap["log_id"];
    this.callerUsername = logMap["caller_Username"];
    this.callerPic = logMap["caller_pic"];
    this.receiverUsername = logMap["receiver_Username"];
    this.receiverPic = logMap["receiver_pic"];
    this.callStatus = logMap["call_status"];
    this.timestamp = logMap["timestamp"];
  }
}