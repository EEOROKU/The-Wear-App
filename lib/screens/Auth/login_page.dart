import 'package:closet_app/locator.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/utils/constants.dart';

import 'package:closet_app/screens/screens.dart';
import 'package:closet_app/helper/helper_function.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();



  final UserController userController = locator.get<UserController>();




  // Method to handle sign-in
  Future<void> _signIn() async {
    String? errorMessage = HelperFunctions.validateInputs(userEmail, userPass);

    if (errorMessage != null) {
      // Show error message returned from validation function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('SignIn Failed'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Don't proceed with sign-in if inputs are not valid
    }
    try {
      // Call the sign-in method from AuthService
      await userController.signInWithEmailAndPassword(userEmail.text, userPass.text);
      // Navigate to HomeScreen upon successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (error) {
      // Display an error dialog if sign-in fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign In Failed'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceVH(height: 50.0),
              const Text(
                'Welcome Back!',
                style: headline1,
              ),
              const SpaceVH(height: 10.0),
              const Text(
                'Please sign in to your account',
                style: headline3,
              ),
              const SpaceVH(height: 60.0),
              textFild(
                controller: userEmail,
                image: 'user.svg',
                hintTxt: 'Email',

              ),
              PasswordTextField(
                controller: userPass,
                hintTxt: 'Password',
              ),
              const SpaceVH(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: headline3,
                    ),
                  ),
                ),
              ),
              const SpaceVH(height: 100.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Mainbutton(
                      onTap: _signIn, // Call _signIn method when button is tapped
                      text: 'Sign in',
                      btnColor: blueButton,
                    ),
                    const SpaceVH(height: 20.0),
                    Mainbutton(
                      onTap: () {},
                      text: 'Sign in with google',
                      image: 'google.png',
                      btnColor: white,
                      txtColor: blackBG,
                    ),
                    const SpaceVH(height: 20.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (builder) => const SignUpPage()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Don\' have an account? ',
                            style: headline.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign Up',
                            style: headlineDot.copyWith(
                              fontSize: 14.0,
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