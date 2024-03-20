import 'package:closet_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/helper_function.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      await DatabaseService(uid: user!.uid).gettingUserData(email);
      return user;

    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      String error = errorContext(e);
      throw error;
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }


  Future<User?> signUpWithEmailAndPassword(String email, String password, String userName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;

      await DatabaseService(uid: user?.uid).savingUserData(userName, email);

      return user;
    }

    on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      String error = errorContext(e);
      throw error;
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred: ${e.toString()}';
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



  // figure out how to handle message
  String errorContext(FirebaseAuthException error){
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
        errorMessage = "An undefined Error happene.";
    }
    return errorMessage;
  }
}
