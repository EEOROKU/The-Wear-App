import 'package:closet_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/helper_function.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  postDetailsToFirestore(String userName) async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = userName;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  FirebaseAuth get firebaseAuthInstance => _auth;

//* Coould figure out how to deal with unique username validation , trying to meet deadline*

  // Future<String?> _getUserEmailByUsername(String username) async {
  //   try {
  //     // Query Firestore to find the user document with the provided username
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('users')
  //         .where('username', isEqualTo: username)
  //         .get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // If user document with the username exists, return the email
  //       return querySnapshot.docs.first.get('email');
  //     } else {
  //       // If user document with the username does not exist, return null
  //       return null;
  //     }
  //   } catch (error) {
  //     // Handle any errors that occur during the process
  //     print('Error getting user email by username: $error');
  //     return null;
  //   }
  // }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      String signInEmail = email;

      // Will try to implement in future
      // if (!email.contains('@')) {
      //   // If email does not contain '@', assume it's a username
      //   String? userEmail = await _getUserEmailByUsername(email);
      //   if (userEmail == null) {
      //     throw 'Username not found.';
      //   }
      //   signInEmail = userEmail;
      // }

      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: signInEmail,
        password: password,
      );
      User? user = credential.user;

      // saving the values to our shared preferences
      await HelperFunctions.saveUserLoggedInStatus(true);
      await HelperFunctions.saveUserEmailSF(signInEmail);
      //await HelperFunctions.saveUserNameSF(snapshot.docs[0]['userName']);
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw 'Invalid email or password.';
      } else {
        throw 'An error occurred: ${errorContext(e.code)}';
      }
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred.';
    }
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


      return user;
    }

    on FirebaseAuthException catch (e) {

      // Handle specific Firebase authentication exceptions
      if (e.code == 'email-already-in-use') {
        throw 'The email address is already in use.';
      } else {
        throw 'An error occurred: ${errorContext(e.code)}';
      }
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred.';
    }

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

  String errorContext(String error){
    String errorMessage ="";
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
