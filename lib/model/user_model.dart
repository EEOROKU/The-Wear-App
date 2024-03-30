import 'package:closet_app/model/cloth_item.dart';

class UserModel {
  String uid;
  String? userEmail;
  String? userName;
  String? avatarUrl;
  Map<String, List<ClothingItemModel>>? clothes;

  UserModel(this.uid, {this.userEmail, this.userName, this.avatarUrl, this.clothes});


  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      map['uid'],
      userEmail: map['email'],
      userName: map['userName'],
      avatarUrl: map['avatarUrl'],
      clothes: map['clothes'] != null
          ? Map<String, List<ClothingItemModel>>.from(map['clothes'])
          : null

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userEmail': userEmail,
      'userName': userName,
      'avatarUrl': avatarUrl,
      'clothes': clothes != null && clothes!.isNotEmpty ? clothes : null,
    };
  }



  // Method to get parent category of a ClothingItemModel
  String getParentCategory(ClothingItemModel item) {
    return item.getParentCategory();
  }


}
