import 'package:closet_app/screens/signup_screen.dart'; // Adjust the import path as necessary
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Setup Firebase (mock or actual initialization)
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets(
      'Signup Screen has email, password, and confirm password fields and a signup button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignupScreen()));

    // Verify that email, password, and confirm password fields are present
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Confirm Password'), findsOneWidget);

    // Verify that the signup button is present
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
  });
}
