// import 'dart:io';
//
// import 'package:closet_app/locator.dart';
// import 'package:closet_app/model/user_model.dart'; // Import the UserModel class
// import 'package:closet_app/services/database_service.dart';
// import 'package:closet_app/services/fire_base_auth.dart';
// import 'package:closet_app/services/storage_repo.dart'; // Import the DatabaseService class
//
// class BackendService {
//   late AuthService authService ;
//   late StorageRepo storageRepo ;
//   late DatabaseService databaseService;
//
//   static void initialize() {
//     // Initialize and register Firebase services
//     final AuthService authService = AuthService();
//     final StorageRepo storageRepo = StorageRepo();
//     final DatabaseService databaseService = DatabaseService();
//
//     // Register Firebase services in the locator
//     locator.registerSingleton<AuthService>(authService);
//     locator.registerSingleton<StorageRepo>(storageRepo);
//     locator.registerSingleton<DatabaseService>(databaseService);
//   }
//   // Initialize the DatabaseService
//
//   // Method to sign up a user with email and password
//   Future<void> signUpWithEmailAndPassword(String email, String password, String userName) async {
//     await authService.signUpWithEmailAndPassword(email, password, userName);
//   }
//
//   // Method to sign in a user with email and password
//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     await authService.signInWithEmailAndPassword(email, password);
//   }
//
//   // Method to sign out the current user
//   Future<void> signOut() async {
//     await authService.signOut();
//   }
//
//   // Method to get the current user's data
//   Future<UserModel?> getCurrentUserData() async {
//     return databaseService.gettingUserData(authService.getCurrentUserID()!);
//
//   }
//
//   // Method to update user data
//   // Future<UserModel> updateUserData(UserModel userData) async {
//   //   return databaseService.updateUserData(userData);
//   // }
//
//
//   Future<String?> uploadUserProfilePicture(String userID, File imageFile) async {
//     try {
//      String? avatarUrl = await storageRepo.uploadUserProfilePicture(userID, imageFile);
//       await DatabaseService(uid: userID).uploadAvatarUrl(avatarUrl!);
//       return avatarUrl;
//     } catch (error) {
//       throw error;
//     }
//   }
//
//   Future<String?> uploadClothingItemPicture(String userID, File imageFile) async {
//     try {
//       return await storageRepo.uploadClothingItemPicture(userID,  imageFile);
//     } catch (error) {
//       throw error;
//     }
//   }
//
// }
