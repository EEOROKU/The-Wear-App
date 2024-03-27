class UserModel {
  String? uid;
  String? userEmail;
  String? userName;


  UserModel({this.uid, this.userEmail, this.userName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      userEmail: map['email'],
      userName: map['userName']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userEmail': userEmail,
      'userName': userName,

    };
  }
}
