import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:closet_app/screens/screens.dart';
import 'package:closet_app/widgets/widgets.dart';

void main() {
  testWidgets('LandingPage UI Test', (WidgetTester tester) async {


    // Verify if 'WEAR.' text is displayed.
    expect(find.text('WEAR.'), findsOneWidget);

    // Verify if 'Create your own digital closet' text is displayed.
    expect(find.text('Create your own digital closet'), findsOneWidget);

    // Verify if the Get Started button is displayed and clickable.
    expect(find.byType(Mainbutton), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete
    expect(find.byType(LoginPage), findsOneWidget);

    // Verify if the 'Have an account? Sign In' link is displayed and clickable.
    expect(find.byType(GestureDetector), findsOneWidget);
    await tester.tap(find.text(' Sign In'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('LandingPage Layout Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: LandingPage(),
    ));

    // Verify if the Scaffold is rendered.
    expect(find.byType(Scaffold), findsOneWidget);

    // Verify if the main Column layout is as expected.
    expect(find.byType(Column), findsOneWidget);

    // Verify the presence of key widgets like Text, Mainbutton, and GestureDetector.
    expect(find.byType(Text), findsNWidgets(3)); // Three Text widgets
    expect(find.byType(Mainbutton), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('LandingPage Widget Dimensions Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: LandingPage(),
    ));

    // Find the main Container within the LandingPage widget.
    final mainContainerFinder = find.descendant(
      of: find.byType(LandingPage),
      matching: find.byType(Container),
    );

    // Ensure that we found exactly one main Container widget.
    expect(mainContainerFinder, findsOneWidget);

    // Get the constraints of the main Container.
    final mainContainer = tester.widget<Container>(mainContainerFinder);
    final constraints = mainContainer.constraints as BoxConstraints;
    final expectedContainerWidth = constraints.maxWidth;

    // Calculate the expected width based on screen width.
    final screenWidth = tester.binding.window.physicalSize.width / tester.binding.window.devicePixelRatio;
    final expectedWidth = screenWidth * 0.9;

    // Verify if the actual width matches the expected width.
    expect(expectedContainerWidth, equals(expectedWidth));
  });
}
