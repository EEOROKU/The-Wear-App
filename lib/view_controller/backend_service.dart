import 'dart:io';

import 'package:closet_app/locator.dart';
import 'package:closet_app/model/user_model.dart'; // Import the UserModel class
import 'package:closet_app/services/database_service.dart';
import 'package:closet_app/services/fire_base_auth.dart';
import 'package:closet_app/services/storage_repo.dart';


class BackendService {
  late AuthService authService;
  late StorageRepo storageRepo;
  late DatabaseService databaseService;

  BackendService() {
    initialize(); // Call initialize method in the constructor
  }

  void initialize() {
    // Initialize and register Firebase services
    authService = AuthService();
    storageRepo = StorageRepo();
    databaseService = DatabaseService();

    // Register Firebase services in the locator
    locator.registerSingleton<AuthService>(authService);
    locator.registerSingleton<StorageRepo>(storageRepo);
    locator.registerSingleton<DatabaseService>(databaseService);
  }
  // Initialize the DatabaseService

  // Method to sign up a user with email and password
  Future<UserModel?> signUpWithEmailAndPassword(String email, String password, String userName) async {
    return authService.signUpWithEmailAndPassword(email, password, userName);
  }

  // Method to sign in a user with email and password
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    return await authService.signInWithEmailAndPassword(email, password);
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    await authService.signOut();
  }

  // Method to get the current user's data
  Future<UserModel?> getCurrentUserData() async {
    return databaseService.gettingUserData(authService.getCurrentUserID()!);

  }


  Future<String?> uploadUserProfilePicture(String userID, File imageFile) async {
    try {
      String? avatarUrl = await storageRepo.uploadUserProfilePicture(userID, imageFile);
      await DatabaseService(uid: userID).uploadAvatarUrl(avatarUrl!);
      return avatarUrl;
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> uploadClothingItemPicture(String userID, File imageFile,String category) async {
    try {
      return await storageRepo.uploadClothingItemPicture(userID,  imageFile, category);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> validatePassword(String email, String password) {
    return authService.validatePassword(email, password);
  }

  Future<void> resetPassword(String email) async {
    authService.resetPassword(email: email);
  }

  void updatePassword(String password) {
    authService.updatePassword(password);}

}