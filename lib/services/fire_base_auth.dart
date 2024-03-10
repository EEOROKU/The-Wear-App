import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw 'Invalid email or password.';
      } else {
        throw 'An error occurred: ${e.message}';
      }
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred.';
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      if (e.code == 'email-already-in-use') {
        throw 'The email address is already in use.';
      } else {
        throw 'An error occurred: ${e.message}';
      }
    } catch (e) {
      // Handle other exceptions
      throw 'An unexpected error occurred.';
    }
  }
}
