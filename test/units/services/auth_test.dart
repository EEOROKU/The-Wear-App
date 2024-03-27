import 'package:closet_app/FIrebase_Initializer.dart';
import 'package:closet_app/services/FIrebaseAuthSingleton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:closet_app/services/fire_base_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUser extends Mock implements User {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late AuthService authService;

  setUp(() async {
    await FirebaseTestInitializer.initializeFirebaseTest();
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    authService = AuthService();
  });

  // Test Cases here
  test('signInWithEmailAndPassword - Success Scenario', () async {
    // Arrange: Create mock user and user credential
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();
    when(mockUser.email).thenReturn('test@example.com');
    when(mockUser.uid).thenReturn('uid');
    when(mockUserCredential.user).thenReturn(mockUser);

    // Arrange: Mock FirebaseAuth to return mock user credential
    when(mockAuth.signInWithEmailAndPassword(email: 'test@example.com', password: 'password123')).thenAnswer((_) async => mockUserCredential);

    // Act: Attempt to sign in
    var result = await authService.signInWithEmailAndPassword('test@example.com', 'password123');

    // Assert: Verify the successful sign in
    expect(result, isNotNull);
    expect(result, isInstanceOf<User>());
    verify(mockAuth.signInWithEmailAndPassword(email: 'test@example.com', password: 'password123')).called(1);
  });

  test('signInWithEmailAndPassword - Failure Scenario', () async {
    // Arrange: Mock FirebaseAuth to throw FirebaseAuthException
    when(mockAuth.signInWithEmailAndPassword(email: 'wrong@example.com', password: 'password123'))
        .thenThrow(FirebaseAuthException(code: 'user-not-found'));

    // Act & Assert: Expect signing in with wrong credentials to throw an exception
    expect(
        authService.signInWithEmailAndPassword('wrong@example.com', 'password123'),
        throwsA(isA<FirebaseAuthException>())
    );
  });

  test('signUpWithEmailAndPassword - Success Scenario', () async {
    // Arrange: Create mock user and user credential
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();
    when(mockUser.email).thenReturn('new@example.com');
    when(mockUser.uid).thenReturn('uid');
    when(mockUserCredential.user).thenReturn(mockUser);
    email: 'new@example.com';
    password: 'password123';

    // Arrange: Mock FirebaseAuth and Firestore behaviors
    when(mockAuth.createUserWithEmailAndPassword(email: 'new@example.com', password: 'password123'))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirestore.collection('users').doc(any).set(anything as Map<String, dynamic>))
        .thenAnswer((_) async => {});

    // Act: Call signUpWithEmailAndPassword
    var result = await authService.signUpWithEmailAndPassword('new@example.com', 'password123', 'NewUser');

    // Assert: Verify the result and Firestore interactions
    expect(result, isNotNull);
    expect(result, isInstanceOf<User>());
    verify(mockFirestore.collection('users').doc(any).set(anything as Map<String, dynamic>)).called(1); //<== here at set(any i am getting "argument_type_not_assignabl The argument type '{0}' can't be assigned to the parameter type '{1}'. {2}"
    // Additional assertions to verify shared preferences logic can be added if necessary
  });

  test('signUpWithEmailAndPassword - Failure Scenario', () async {
    // Arrange: Mock FirebaseAuth to throw FirebaseAuthException
    when(mockAuth.createUserWithEmailAndPassword(email: 'existing@example.com', password: 'password123'))
        .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

    // Act & Assert: Expect signing up with an existing email to throw an exception
    expect(
        authService.signUpWithEmailAndPassword('existing@example.com', 'password123', 'ExistingUser'),
        throwsA(isA<FirebaseAuthException>())
    );
  });

  // Tear down Firebase after tests are complete (optional)
  tearDownAll(() async {
    await FirebaseTestInitializer.tearDownFirebaseTest();
  });

}

/*
this is the error meessege i am getting when i run to test this file.

"G:\programes to install\flutter_windows_3.19.3-stable\flutter\bin\flutter.bat" --no-color test --machine --start-paused test\screens\Auth\auth_test.dart
Testing started at 7:11 AM ...
test/screens/Auth/auth_test.dart:72:57: Error: The argument type 'Null' can't be assigned to the parameter type 'Map<String, dynamic>' because 'Map<String, dynamic>' is not nullable.
 - 'Map' is from 'dart:core'.
    when(mockFirestore.collection('users').doc(any).set(any))
                                                        ^
test/screens/Auth/auth_test.dart:81:59: Error: The argument type 'Null' can't be assigned to the parameter type 'Map<String, dynamic>' because 'Map<String, dynamic>' is not nullable.
 - 'Map' is from 'dart:core'.
    verify(mockFirestore.collection('users').doc(any).set(any)).called(1); //<== here at set(any i am getting "argument_type_not_assignabl The argument type '{0}' can't be assigned to the parameter type '{1}'. {2}"
                                                          ^
Failed to load "E:/temp move/CS-3130/project/test/screens/Auth/auth_test.dart": Compilation failed for testPath=E:/temp move/CS-3130/project/test/screens/Auth/auth_test.dart


 */