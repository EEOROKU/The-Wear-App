import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:closet_app/screens/Auth/sign_up.dart';
import 'package:closet_app/screens/home_screen.dart';
import 'package:closet_app/services/fire_auth.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('SignUpPage Widget Tests', () {
    late SignUpPage signUpPage;
    late MockAuthService mockAuthService;

    setUp(() {
      signUpPage = const SignUpPage();
      mockAuthService = MockAuthService();
    });

    testWidgets('Test Sign Up with valid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));

      final userNameField = find.byKey(const Key('userNameTextField'));
      final userEmailField = find.byKey(const Key('userEmailTextField'));
      final userPassField = find.byKey(const Key('userPassTextField'));
      await tester.enterText(userNameField, 'Test User');
      await tester.enterText(userEmailField, 'test@example.com');
      await tester.enterText(userPassField, 'password');

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      verify(mockAuthService.signUpWithEmailAndPassword('test@example.com', 'password', 'Test User')).called(1);

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Test Sign Up with invalid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));

      final userNameField = find.byKey(const Key('userNameTextField'));
      final userEmailField = find.byKey(const Key('userEmailTextField'));
      final userPassField = find.byKey(const Key('userPassTextField'));
      await tester.enterText(userNameField, '');
      await tester.enterText(userEmailField, 'invalidemail');
      await tester.enterText(userPassField, '123');

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      verifyNever(mockAuthService.signUpWithEmailAndPassword("abc@gmail.com", "ABCabc123", "abc"));

      expect(find.byType(HomeScreen), findsNothing);
    });

  });
}
