class UserModel {
  String uid;
  String? userEmail;
  String? userName;
  String? avatarUrl;

  UserModel(this.uid, {this.userEmail, this.userName, this.avatarUrl});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      map['uid'],
      userEmail: map['email'],
      userName: map['userName'],
      avatarUrl: map['avatarUrl']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userEmail': userEmail,
      'userName': userName,
    'avatarUrl':avatarUrl,

    };
  }
}
