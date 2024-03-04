import 'package:closet_app/screens/login_screen.dart'; // Adjust the import path as necessary
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Setup Firebase (mock or actual initialization)
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Login Screen has email and password fields and a login button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Verify that email and password fields are present
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Verify that the login button is present
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
