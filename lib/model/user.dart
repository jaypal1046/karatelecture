class OurUser{
  String uid;
  String fullName;
  String email;
  String username;
  String status;
  List<String> roomName;
  int state;
  String profilePhoto;
  OurUser({
    this.uid,
    this.fullName,
    this.email,
    this.username,
    this.status,
    this.state,
    this.roomName,
    this.profilePhoto,
    }
    );
  Map toMap(OurUser user){
    var data=Map<String,dynamic>();
    data['uid']=user.uid;
    data['name']=user.fullName;
    data['email']=user.email;
    data['lectureId']=user.
    roomName;
    data['username']=user.username;
    data['status']=user.status;
    data['state']=user.state;
    data['profilePhoto']=user.profilePhoto;
    return data;

  }
  OurUser.fromMap(Map<String,dynamic>map){
    this.uid=map['uid'];
    this.fullName=map['name'];
    this.email=map['email'];
    this.username=map['username'];
    this.status=map['status'];
    this.roomName=map["lectureId"];
    this.state=map['state'];
    this.profilePhoto=map['profilePhoto'];




  }








}