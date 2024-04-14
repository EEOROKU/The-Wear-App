import 'package:closet_app/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/utils/constants.dart';
import "package:closet_app/services/fire_auth.dart"; // Import the AuthService
import 'package:closet_app/screens/screens.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> _signUp() async {
    String? errorMessage = HelperFunctions.validateInputs(userEmail, userPass);

    if (errorMessage != null) {
      // Show error message returned from validation function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('SignUp Failed'),
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
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.signUpWithEmailAndPassword(
            userEmail.text, userPass.text, userName.text);
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
      backgroundColor: const Color(0xFF181A20),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SpaceVH(height: 50.0),
              const Text(
                'SIGN UP',
                style: headline1,
              ),
              const SpaceVH(height: 10.0),
              // const Text(
              //   'Please fill in the form to continue',
              //   style: headline3,
              // ),
              const Expanded(child: SpaceVH(height: 80.0)),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.5
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 70.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                  decoration: BoxDecoration(
                    color: blackTextFild,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      userName.text = value;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/icon/user.svg',
                          height: 10.0,
                          width: 10.0,
                          color: grayText,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: "Username",
                      hintStyle: hintStyle,
                    ),
                    style: headline2,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 0.5
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 70.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                  decoration: BoxDecoration(
                    color: blackTextFild,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      userEmail.text = value;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/icon/user.svg',
                          height: 10.0,
                          width: 10.0,
                          color: grayText,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: "Email Address",
                      hintStyle: hintStyle,
                    ),
                    style: headline2,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 0.5
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 70.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: blackTextFild,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    controller: userPass,
                    onChanged: (value) {
                      userPass.text = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: hintStyle,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            _obscureText ? 'assets/icon/hide.svg' : 'assets/icon/visibility.svg',
                            height: 10.0,
                            width: 10.0,
                            color: grayText,
                          ),
                        ),
                      ),
                    ),
                    style: headline2,
                  ),
                ),
              ),
              const Expanded(child: SpaceVH(height: 80.0)),
              const Expanded(child: SpaceVH(height: 80.0)),
              Mainbutton(
                onTap: _signUp, // Call _signUp method when button is tapped
                text: 'Sign Up',
                btnColor: const Color(0xFF303877),
              ),
              const SpaceVH(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const LoginPage()),
                  );
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
              ),
              const SpaceVH(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
