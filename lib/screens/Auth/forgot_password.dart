import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/helper/helper_function.dart';

import '../../locator.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final UserController userController = locator.get<UserController>();

  String? _errorMessage;

  Future<void> _resetPassword() async {
    setState(() {
      _errorMessage = null; // Clear previous error message
    });

    try {
      // Call the method to reset the password
      await userController.resetPassword(emailController.text);
      // Display success dialog upon successful password reset
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Successful'),
            content: Text('Password reset email sent to ${emailController.text} if email exists'),
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
      // Display an error dialog if password reset fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Failed'),
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
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
              ),
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
              onTap: _resetPassword,
              text: 'Reset Password',
              btnColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
