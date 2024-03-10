import 'package:closet_app/screens/screens.dart'; // Importing screens
import 'package:closet_app/widgets/widgets.dart'; // Importing widgets
import 'package:flutter/material.dart';
import 'package:closet_app/utils/constants.dart'; // Importing constants

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG, // Set background color
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceVH(height: 50.0), // Vertical space
              const Text(
                'Welcome Back!', // Display welcome message
                style: headline1, // Apply headline1 style
              ),
              const SpaceVH(height: 10.0), // Vertical space
              const Text(
                'Please sign in to your account', // Display sign-in message
                style: headline3, // Apply headline3 style
              ),
              const SpaceVH(height: 60.0), // Vertical space
              textFild(
                controller: userName,
                image: 'user.svg', // Display user icon
                hintTxt: 'Username', // Display username hint
              ),
              textFild(
                controller: userPass,
                image: 'hide.svg', // Display password icon
                isObs: true, // Set password text field as obscured
                hintTxt: 'Password', // Display password hint
              ),
              const SpaceVH(height: 10.0), // Vertical space
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {}, // Forgot password button functionality
                    child: const Text(
                      'Forgot Password?', // Display forgot password option
                      style: headline3, // Apply headline3 style
                    ),
                  ),
                ),
              ),
              const SpaceVH(height: 100.0), // Vertical space
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Mainbutton(
                      onTap: () {}, // Sign in button functionality
                      text: 'Sign in', // Display sign in button
                      btnColor: blueButton, // Apply blue button color
                    ),
                    const SpaceVH(height: 20.0), // Vertical space
                    Mainbutton(
                      onTap: () {}, // Sign in with Google button functionality
                      text: 'Sign in with google', // Display Google sign-in button
                      image: 'google.png', // Display Google icon
                      btnColor: white, // Apply white button color
                      txtColor: blackBG, // Apply black text color
                    ),
                    const SpaceVH(height: 20.0), // Vertical space
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const SignUpPage())); // Navigate to SignUpPage
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Don\' have an account? ', // Display sign-up message
                            style: headline.copyWith(
                              fontSize: 14.0, // Apply custom font size
                            ),
                          ),
                          TextSpan(
                            text: ' Sign Up', // Display Sign Up link
                            style: headlineDot.copyWith(
                              fontSize: 14.0, // Apply custom font size
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
