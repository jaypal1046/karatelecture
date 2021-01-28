

/*class CurrentGroupState extends ChangeNotifier{
  OurGroup _currentGroup=OurGroup();
  OurBook _currentBook=OurBook();
  bool donewithCurrentBook=false;
  OurGroup get getCurrentGroup=>_currentGroup;
  OurBook get getCurrentBook=>_currentBook;
  bool get getDoneWithCurrentBook=>donewithCurrentBook;
  void updateStateFromDatabase(String groupId,String uid)async{
    try{
      //TODO:get the groupInfo from firebase and get the current book info from firebase.
      _currentGroup=await OurDatabse().getGroupInfo(groupId);
      _currentBook=await OurDatabse().getCurrentBook(groupId, _currentGroup.currentBookId);
      donewithCurrentBook=await OurDatabse().IsUserDoneWithBook(groupId, _currentGroup.currentBookId, uid);
      notifyListeners();
    }catch(e){
      print(e);
    }


  }
  void finishedBook(String uid,int rating,String review)async{
    try{
      await OurDatabse().finishedBook(_currentGroup.id, _currentGroup.currentBookId, uid, rating, review);
      donewithCurrentBook=true;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }
}*/