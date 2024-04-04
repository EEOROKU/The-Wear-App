import 'dart:io';
import 'package:closet_app/model/cloth_item.dart';
import 'package:closet_app/model/model.dart';
import 'package:closet_app/services/database_service.dart';
import 'package:closet_app/view_controller/backend_service.dart';

class UserController {
  final BackendService _backendService;

  UserController(this._backendService);

  late UserModel _currentUserUC;

  Future<void> initUser() async {
    _currentUserUC = (await _backendService
        .getCurrentUserData())!; // Use BackendService to get user data

  }

  UserModel get currentUser => _currentUserUC;

  Future<void> uploadProfilePicture(File image) async {
    _currentUserUC.avatarUrl =
    await _backendService.uploadUserProfilePicture(_currentUserUC.uid!, image);
  }

  Future<String?> uploadclothPicture(String category,File image) {
    return _backendService.uploadClothingItemPicture(_currentUserUC.uid!, image,category);
  }


  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _backendService.signInWithEmailAndPassword(
        email, password);

    _currentUserUC.avatarUrl = user?.avatarUrl;
  }

  Future<void> signUpWithEmailAndPassword(String email, String password,
      String userName) async {
    _currentUserUC = (await _backendService.signUpWithEmailAndPassword(
        email, password, userName))!;

    _currentUserUC.avatarUrl = _currentUserUC.avatarUrl;
  }

  void updateUserName(String userName) {
    _currentUserUC.userName = userName;
  }

  Future<bool> validateCurrentPassword(String email, String password) async {
    return await _backendService.validatePassword(email, password);
  }

  void updateUserPassword(String password) {
    _backendService.updatePassword(password);
  }

  Future<void> saveClothingItem(ClothingItemModel item) async {

    await DatabaseService(uid: currentUser.uid).addClothingItem(item);
  }


  Future<void> resetPassword(String email) async {
    _backendService.resetPassword(email);
  }


  Future<void> signOut() async {
    _backendService.signOut();
  }



}