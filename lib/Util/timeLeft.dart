class OurTimeLeft{
  List<String> Timeleft(DateTime due){
    List<String> retVal=List(2);
    Duration _timeUntilDue=due.difference( DateTime.now());
    int _daysUntil=_timeUntilDue.inDays;
    int _hoursUntil=_timeUntilDue.inHours-(_daysUntil*24);
    int _minUntil=_timeUntilDue.inMinutes-(_daysUntil*24*60)-(_hoursUntil*60);
    int _secUntil=_timeUntilDue.inSeconds-(_daysUntil*24*60*60)-(_hoursUntil*60*60)-(_minUntil*60);
if(_daysUntil>0) {
  retVal[0] = _daysUntil.toString() + "D\n" + _hoursUntil.toString() + "H \n" +
      _minUntil.toString() + "M\n" + _secUntil.toString() + "S";
}else if(_hoursUntil>0){
  retVal[0] =  _hoursUntil.toString() + "H \n" +
      _minUntil.toString() + "M\n" + _secUntil.toString() + "S";

}else if(_minUntil>0){
  retVal[0] =
      _minUntil.toString() + "M\n" + _secUntil.toString() + "S";
}else if (_secUntil>0){
  retVal[0] =  _secUntil.toString() + "S";

}else{
  retVal[0]="error";
}
Duration timeUntilRevel =due.subtract(Duration(days: 7)).difference(DateTime.now());

    int _daysUntilRevel=timeUntilRevel.inDays;
    int _hoursUntilRevel=timeUntilRevel.inHours-(_daysUntilRevel*24);
    int _minUntilRevel=timeUntilRevel.inMinutes-(_daysUntilRevel*24*60)-(_hoursUntilRevel*60);
    int _secUntilRevel=timeUntilRevel.inSeconds-(_daysUntilRevel*24*60*60)-(_hoursUntilRevel*60*60)-(_minUntilRevel*60);
if(_daysUntilRevel>0) {
      retVal[1] = _daysUntilRevel.toString() + "D\n" + _hoursUntilRevel.toString() + "H \n" +
          _minUntilRevel.toString() + "M\n" + _secUntilRevel.toString() + "S";
    }else if(_hoursUntilRevel>0){
      retVal[1] =  _hoursUntilRevel.toString() + "H \n" +
          _minUntilRevel.toString() + "M\n" + _secUntilRevel.toString() + "S";

    }else if(_minUntilRevel>0){
      retVal[1] =
          _minUntilRevel.toString() + "M\n" + _secUntilRevel.toString() + "S";
    }else if (_secUntilRevel>0){
      retVal[1] =  _secUntilRevel.toString() + "S";

    }else{
      retVal[1]="error";
    }


    return retVal;
  }
}