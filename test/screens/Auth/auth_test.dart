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
    FirebaseAuthSingleton.instance = mockAuth;
    FirebaseFirestoreSingleton.instance = mockFirestore;
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

    // Arrange: Mock FirebaseAuth and Firestore behaviors
    when(mockAuth.createUserWithEmailAndPassword(email: 'new@example.com', password: 'password123'))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirestore.collection('users').doc(argThat(isNotNull)).set( {
      'name': 'abc', // Specify the 'name' field with value 'abc'
      // You can add more fields as needed
    }))
        .thenAnswer((_) async => {});

    // Act: Call signUpWithEmailAndPassword
    var result = await authService.signUpWithEmailAndPassword('new@example.com', 'password123', 'NewUser');

    // Assert: Verify the result and Firestore interactions
    expect(result, isNotNull);
    expect(result, isInstanceOf<User>());
    verify(mockFirestore.collection('users').doc(any).set( {
      'name': 'abc', // Specify the 'name' field with value 'abc'
      // You can add more fields as needed
    })).called(1); //<== here at set(any i am getting "argument_type_not_assignabl The argument type '{0}' can't be assigned to the parameter type '{1}'. {2}"
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
