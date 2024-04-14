import 'package:closet_app/FIrebase_Initializer.dart';
import 'package:closet_app/services/FIrebaseAuthSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:closet_app/services/fire_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('AuthService Tests', () {
    late AuthService authService = AuthService();
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;

    setUp(() async {
      await FirebaseTestInitializer.initializeFirebaseTest();
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      FirebaseAuthSingleton.instance = mockFirebaseAuth;
      FirebaseFirestoreSingleton.instance = mockFirebaseFirestore;
    });

    test('Test sign in with valid credentials', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'test@example.com', password: 'password'))
          .thenAnswer((_) => Future.value(null));
      expect(await authService.signInWithEmailAndPassword('test@example.com', 'password'), isNull);
    });

    test('Test sign in with invalid email or password', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'invalid@example.com', password: 'password'))
          .thenThrow('Invalid email or password.');
      expect(() => authService.signInWithEmailAndPassword('invalid@example.com', 'password'),
          throwsA('Invalid email or password.'));
    });

  });
}