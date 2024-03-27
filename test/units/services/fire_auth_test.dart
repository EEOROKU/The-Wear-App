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

/*
this an errro messahe i am getting when runnign the tests.

"G:\programes to install\flutter_windows_3.19.3-stable\flutter\bin\flutter.bat" --no-color test --machine --start-paused --plain-name "AuthService Tests" test\screens\Auth\fire_base_auth-1.dart
Testing started at 7:03 AM ...

package:flutter/src/foundation/binding.dart 300:9                                               BindingBase.checkInstance.<fn>
package:flutter/src/foundation/binding.dart 381:6                                               BindingBase.checkInstance
package:flutter/src/services/binding.dart 60:54                                                 ServicesBinding.instance
package:flutter/src/services/platform_channel.dart 158:25                                       _findBinaryMessenger
package:flutter/src/services/platform_channel.dart 204:56                                       BasicMessageChannel.binaryMessenger
package:flutter/src/services/platform_channel.dart 218:38                                       BasicMessageChannel.send
package:firebase_core_platform_interface/src/pigeon/messages.pigeon.dart 208:52                 FirebaseCoreHostApi.initializeCore
package:firebase_core_platform_interface/src/method_channel/method_channel_firebase.dart 29:54  MethodChannelFirebase._initializeCore
package:firebase_core_platform_interface/src/method_channel/method_channel_firebase.dart 73:13  MethodChannelFirebase.initializeApp
package:firebase_core/src/firebase.dart 43:47                                                   Firebase.initializeApp
package:closet_app/FIrebase_Initializer.dart 7:20                                               FirebaseTestInitializer.initializeFirebaseTest
test\screens\Auth\fire_base_auth-1.dart 19:37                                                   main.<fn>.<fn>

Binding has not yet been initialized.
The "instance" getter on the ServicesBinding binding mixin is only available once that binding has been initialized.
Typically, this is done by calling "WidgetsFlutterBinding.ensureInitialized()" or "runApp()" (the latter calls the former). Typically this call is done in the "void main()" method. The "ensureInitialized" method is idempotent; calling it multiple times is not harmful. After calling that method, the "instance" getter will return the binding.
In a test, one can call "TestWidgetsFlutterBinding.ensureInitialized()" as the first line in the test's "main()" method to initialize the binding.
If ServicesBinding is a custom binding mixin, there must also be a custom binding class, like WidgetsFlutterBinding, but that mixes in the selected binding, and that is the class that must be constructed before using the "instance" getter.

package:flutter/src/foundation/binding.dart 300:9                                               BindingBase.checkInstance.<fn>
package:flutter/src/foundation/binding.dart 381:6                                               BindingBase.checkInstance
package:flutter/src/services/binding.dart 60:54                                                 ServicesBinding.instance
package:flutter/src/services/platform_channel.dart 158:25                                       _findBinaryMessenger
package:flutter/src/services/platform_channel.dart 204:56                                       BasicMessageChannel.binaryMessenger
package:flutter/src/services/platform_channel.dart 218:38                                       BasicMessageChannel.send
package:firebase_core_platform_interface/src/pigeon/messages.pigeon.dart 208:52                 FirebaseCoreHostApi.initializeCore
package:firebase_core_platform_interface/src/method_channel/method_channel_firebase.dart 29:54  MethodChannelFirebase._initializeCore
package:firebase_core_platform_interface/src/method_channel/method_channel_firebase.dart 73:13  MethodChannelFirebase.initializeApp
package:firebase_core/src/firebase.dart 43:47                                                   Firebase.initializeApp
package:closet_app/FIrebase_Initializer.dart 7:20                                               FirebaseTestInitializer.initializeFirebaseTest
test\screens\Auth\fire_base_auth-1.dart 19:37                                                   main.<fn>.<fn>

Binding has not yet been initialized.
The "instance" getter on the ServicesBinding binding mixin is only available once that binding has been initialized.
Typically, this is done by calling "WidgetsFlutterBinding.ensureInitialized()" or "runApp()" (the latter calls the former). Typically this call is done in the "void main()" method. The "ensureInitialized" method is idempotent; calling it multiple times is not harmful. After calling that method, the "instance" getter will return the binding.
In a test, one can call "TestWidgetsFlutterBinding.ensureInitialized()" as the first line in the test's "main()" method to initialize the binding.
If ServicesBinding is a custom binding mixin, there must also be a custom binding class, like WidgetsFlutterBinding, but that mixes in the selected binding, and that is the class that must be constructed before using the "instance" getter.


 */