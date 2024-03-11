import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:closet_app/screens/screens.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Closet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set SplashPage as initial route
      initialRoute: '/',
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
  const AuthenticationWrapper({Key? key}) : super(key: key);

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
