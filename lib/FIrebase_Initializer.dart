import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class FirebaseTestInitializer {
  // Initialize Firebase for testing
  static Future<void> initializeFirebaseTest() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Tear down Firebase instance after testing
  static Future<void> tearDownFirebaseTest() async {
    await Firebase.app().delete();
  }
}
