import 'dart:io';

import 'package:closet_app/locator.dart';
import 'package:closet_app/model/model.dart';
import 'package:closet_app/services/fire_auth.dart';
import 'package:closet_app/services/storage_repo.dart';

import '../services/database_service.dart';


class UserController {
  late UserModel _currentUser; // Declare _currentUser as late
  final AuthService _authService = locator.get<AuthService>();
  final StorageRepo _storageRepo = locator.get<StorageRepo>();

  late Future<void> init; // Declare init as late

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    final user = await _authService.getCurrentUser();

    _currentUser = await DatabaseService(uid: user.uid).gettingUserData(user.uid); // Await the result of gettingUserData
    return _currentUser;
  }


  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(File image) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(image);
    await DatabaseService(uid: _currentUser.uid).uploadAvatarUrl(_currentUser.avatarUrl!);
  }

  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImage(currentUser.uid);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _authService.signInWithEmailAndPassword(email, password);
    _currentUser = UserModel(user!.uid); // Initialize _currentUser
    _currentUser.avatarUrl = await getDownloadUrl();
  }

  void updateDisplayName(String userName) {
    _currentUser.userName = userName;
    _authService.updateDisplayName(userName);
  }

  Future<bool> validateCurrentPassword(String email, String password) async {
    return await _authService.validatePassword(email, password);
  }

  void updateUserPassword(String password) {
    _authService.updatePassword(password);
  }
}
