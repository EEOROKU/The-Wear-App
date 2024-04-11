import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class StorageRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadUserProfilePicture(String userId,File file) async {
    try {

      var storageRef = _storage.ref().child("users/$userId/profilepic.jpg");
      await storageRef.putFile(file);
      String imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print("Error uploading Profile Picture: $error");
      return null;
    }
  }

  Future<String?> uploadClothingItemPicture(String userId,File file,String category) async {
    try {
      var storageRef = _storage.ref().child("users/$userId/clothes/$category/${file.path.split('/').last}");
      await storageRef.putFile(file);
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Error uploading cloth: $error");
      return null;
    }
  }

}