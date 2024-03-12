import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/utils/constants.dart';
import "package:closet_app/services/fire_auth.dart"; // Import the AuthService
import 'package:closet_app/screens/screens.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();

  final AuthService _authService = AuthService(); // Initialize the AuthService

  Future<void> _signUp() async {

    if (_formKey.currentState!.validate()) {
      try {
        await _authService.signUpWithEmailAndPassword(
            userEmail.text, userPass.text, userName.text);
        // SignUp successful, navigate to HomeScreen or another page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      } catch (error) {
        // SignUp failed, show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Failed'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SpaceVH(height: 50.0),
                const Text(
                  'Create new account',
                  style: headline1,
                ),
                const SpaceVH(height: 10.0),
                const Text(
                  'Please fill in the form to continue',
                  style: headline3,
                ),
                const SpaceVH(height: 60.0),
                textFild(
                  controller: userName,
                  image: 'user.svg',
                  keyBordType: TextInputType.name,
                  hintTxt: 'User Name',
                ),
                textFild(
                  controller: userEmail,
                  keyBordType: TextInputType.emailAddress,
                  image: 'user.svg',
                  hintTxt: 'Email Address',

                ),
                textFild(
                  controller: userPass,
                  isObs: true,
                  image: 'hide.svg',
                  hintTxt: 'Password',

                ),
                const SpaceVH(height: 80.0),
                Mainbutton(
                  onTap: _signUp, // Call _signUp method when button is tapped
                  text: 'Sign Up',
                  btnColor: blueButton,
                ),
                const SpaceVH(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Have an account? ',
                        style: headline.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                      TextSpan(
                        text: ' Sign In',
                        style: headlineDot.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
