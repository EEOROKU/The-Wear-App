import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/helper/helper_function.dart';

import '../../locator.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String userEmail;

  const ForgotPasswordPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final UserController userController = locator.get<UserController>();

  String? _errorMessage;

  Future<void> _changePassword() async {
    setState(() {
      _errorMessage = null; // Clear previous error message
    });

    // Validate password inputs
    String? errorMessage = HelperFunctions.validatePassword(newPasswordController);
    if (errorMessage != null) {
      setState(() {
        _errorMessage = errorMessage;
      });
      return; // Don't proceed with changing password if input is not valid
    }

    // Check if the confirmed password matches the new password
    if (newPasswordController.text != confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords don't match";
      });
      return; // Don't proceed if passwords don't match
    }

    try {
      // Call the method to change the password
       userController.updateUserPassword(newPasswordController.text);
      // Display success dialog upon successful change of password
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Password Success'),
            content: const Text('Your password has been changed successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Display an error dialog if changing password fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Password Failed'),
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
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textFild(
              controller: emailController,
              image: 'user.svg',
              hintTxt: 'Email',
            ),
            const SizedBox(height: 10.0),
            PasswordTextField(
              controller: confirmPasswordController,
              hintTxt: 'Confirm Password',
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20.0),
            Mainbutton(
              onTap: _changePassword,
              text: 'Change Password',
              btnColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
