import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:closet_app/screens/Auth/login_page.dart';

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('Empty Email and Password Validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.tap(find.text('Sign in'));
      await tester.pump();

      expect(find.text('Validation Error'), findsOneWidget);
      expect(find.text('Please enter both email and password.'), findsOneWidget);
    });

    testWidgets('Invalid Email Format Validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.enterText(find.byKey(const Key('emailTextField')), 'invalidemail');
      await tester.enterText(find.byKey(const Key('passwordTextField')), 'password');
      await tester.pump();

      await tester.tap(find.text('Sign in'));
      await tester.pump();

      expect(find.text('Validation Error'), findsOneWidget);
      expect(find.text('Please enter a valid email address.'), findsOneWidget);
    });

    testWidgets('Short Password Validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.enterText(find.byKey(const Key('emailTextField')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('passwordTextField')), '123');
      await tester.pump();

      await tester.tap(find.text('Sign in'));
      await tester.pump();

      expect(find.text('Validation Error'), findsOneWidget);
      expect(find.text('Password must be at least 5 characters long.'), findsOneWidget);
    });

  });
}