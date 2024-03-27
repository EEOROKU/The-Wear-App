import 'package:closet_app/FIrebase_Initializer.dart';
import 'package:closet_app/screens/landing_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:closet_app/screens/home_screen.dart';
import 'package:closet_app/services/fire_auth.dart';
import 'package:closet_app/helper/helper_function.dart';

class MockAuthService extends Mock implements AuthService {}
class MockHelperFunctions extends Mock implements HelperFunctions {}

void main() {

  group('HomeScreen Widget Tests', () {
    late HomeScreen homeScreen;
    late MockAuthService mockAuthService;
    late MockHelperFunctions mockHelperFunctions;

    setUp(() async {
      await FirebaseTestInitializer.initializeFirebaseTest();
      mockAuthService = MockAuthService();
      mockHelperFunctions = MockHelperFunctions();
      homeScreen = HomeScreen();
    });

    testWidgets('Test initial state', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: homeScreen));

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('Test logout action', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: homeScreen));

      await tester.tap(find.byType(ActionChip));
      await tester.pumpAndSettle();

      expect(find.text('Logout'), findsOneWidget);
      expect(find.text('Are you sure you want to logout?'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.done));
      await tester.pumpAndSettle();

      verify(mockAuthService.signOut()).called(1);

      expect(find.byType(LandingPage), findsOneWidget);
    });

  });
}
