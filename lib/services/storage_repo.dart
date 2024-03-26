import 'dart:io';
import 'package:closet_app/locator.dart';
import 'package:closet_app/services/fire_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance
    ..bucket = "gs://team-eagles---wear-app.appspot.com";

  final AuthService _authService = locator.get<AuthService>();

  Future<String> uploadFile(File file) async {
    var user = await _authService.getCurrentUser();
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    TaskSnapshot uploadTaskSnapshot = await storageRef.putFile(file);
    String downloadUrl = await uploadTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}
