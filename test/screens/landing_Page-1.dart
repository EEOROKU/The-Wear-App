import 'package:closet_app/screens/Auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:closet_app/screens/landing_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LandingPage Widget Tests', () {
    late LandingPage landingPage;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      landingPage = const LandingPage();
      mockNavigatorObserver = MockNavigatorObserver();
    });

    // testWidgets('Test Get Started button tap', (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: landingPage, navigatorObservers: [mockNavigatorObserver]));
    //
    //   await tester.tap(find.text('Get Started'));
    //   await tester.pumpAndSettle();
    //
    //   verify(mockNavigatorObserver.didPush(any, any));
    //   expect(find.byType(LoginPage), findsOneWidget);
    // });

    // testWidgets('Test Sign In text button tap', (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: landingPage, navigatorObservers: [mockNavigatorObserver]));
    //
    //   await tester.tap(find.text('Sign In'));
    //   await tester.pumpAndSettle();
    //
    //   verify(mockNavigatorObserver.didPush(any, any));
    //   expect(find.byType(LoginPage), findsOneWidget);
    // });

  });
}
