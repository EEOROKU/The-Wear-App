import 'package:closet_app/model/model.dart';

import 'package:closet_app/services/database_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'FIrebaseAuthSingleton.dart';
import '../helper/helper_function.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuthSingleton.instance;
  final FirebaseFirestore _firestore = FirebaseFirestoreSingleton.instance;

  postDetailsToFirestore(String userName) async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel(user!.uid);
    // writing all the values
    userModel.userEmail = user!.email;

    userModel.userName = userName;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  FirebaseAuth get firebaseAuthInstance => _auth;



  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      String signInEmail = email;

      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: signInEmail,
        password: password,
      );
      User? user = credential.user;

      await DatabaseService(uid: user!.uid).gettingUserData(user.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw 'Invalid email or password.';
      } else {
        throw 'An error occurred: ${errorContext(e)}';
      }
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred.';
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    var user = _auth.currentUser;
    user?.updateDisplayName(displayName);
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password, String userName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      postDetailsToFirestore(userName);

      // saving the values to our shared preferences
      await HelperFunctions.saveUserLoggedInStatus(true);
      await HelperFunctions.saveUserEmailSF(email);
      await HelperFunctions.saveUserNameSF(userName);

      await DatabaseService(uid: user?.uid).savingUserData(userName, email, "");

      return user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      if (e.code == 'email-already-in-use') {
        throw 'The email address is already in use.';
      } else {
        throw 'An error occurred: ${errorContext(e)}';
      }
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred.';
    }
  }
  // Get current user
  Future<UserModel> getCurrentUser() async {
    var user = _auth.currentUser;
    if (user != null) {
      UserModel usermodel = await DatabaseService(uid: user.uid).gettingUserData(user.uid);
      return usermodel;
    } else {
      throw Exception("User is not authenticated");
    }
  }

  Future<bool> validatePassword(String email, String password) async {
    var user = _auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(email: email, password: password);
    try {
      var authResult = await user?.reauthenticateWithCredential(authCredentials);
      return authResult?.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var user = _auth.currentUser;
    user?.updatePassword(password);

  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
  // figure out how to handle message
  String errorContext(FirebaseAuthException error) {
    String errorMessage = "";

    switch (error) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    return errorMessage;
  }
}
