import 'package:closet_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:closet_app/screens/screens.dart';

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('LoginPage UI Test', (WidgetTester tester) async {
      // Pump the LoginPage widget into the test environment
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Verify the presence of specific text widgets and UI elements
      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.text('Please sign in to your account'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(Mainbutton), findsNWidgets(2));
      expect(find.text('Forgot Password?'), findsOneWidget);
    });
  });

  group('SignUpPage Widget Tests', () {
    testWidgets('SignUpPage UI Test', (WidgetTester tester) async {
      // Pump the SignUpPage widget into the test environment
      await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

      // Verify the presence of specific text widgets and UI elements
      expect(find.text('Create new account'), findsOneWidget);
      expect(find.text('Please fill in the form to continue'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(4));
      expect(find.byType(Mainbutton), findsOneWidget);
    });
  });

  group('HomePage Widget Tests', () {
    testWidgets('HomePage UI Test', (WidgetTester tester) async {
      // Pump the HomePage widget into the test environment
      await tester.pumpWidget(const MaterialApp(home: LandingPage()));

      // Verify the presence of specific text widgets and UI elements
      expect(find.text('WEAR'), findsOneWidget);
      expect(find.byType(Mainbutton), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });
  });
}
