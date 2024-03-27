import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//this instances will change during testing but in normal
//circumstances these will not change unless specifically called to change.
class FirebaseAuthSingleton {
  static FirebaseAuth? _instance;

  static set instance(FirebaseAuth instance) => _instance = instance;
  static FirebaseAuth get instance => _instance ?? FirebaseAuth.instance;
}

class FirebaseFirestoreSingleton {
  static FirebaseFirestore? _instance;

  static set instance(FirebaseFirestore instance) => _instance = instance;
  static FirebaseFirestore get instance => _instance ?? FirebaseFirestore.instance;
}
