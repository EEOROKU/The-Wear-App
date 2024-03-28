import 'package:closet_app/view_controller/backend_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/locator.dart'; // Import the file where setupServices() is defined
import 'package:closet_app/firebase_options.dart'; // Assuming you have this file for Firebase options

import 'helper/helper_function.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase

  setupServices();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  Future<void> getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WEAR App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set SplashPage as initial route
      initialRoute: _isSignedIn ? '/home' : '/',
      routes: {
        '/': (context) => const LandingPage(), // Route to SplashScreen
        '/login': (context) => const LoginPage(), // Route to LoginPage
        '/signup': (context) => const SignUpPage(), // Route to SignUpPage
        '/home': (context) => const AuthenticationWrapper(), // Route to AuthenticationWrapper
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), // Listen to authentication state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LandingPage(); // Show SplashScreen while waiting for auth state
        } else {
          if (snapshot.hasData) {
            return const HomeScreen(); // If user is authenticated, show HomeScreen
          } else {
            return const LoginPage(); // If user is not authenticated, show LoginPage
          }
        }
      },
    );
  }
}
