import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/helper/helper_function.dart';

import '../../locator.dart';
import '../home_screen.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController newPasswordController = TextEditingController();

  final UserController userController = locator.get<UserController>();

  Future<void> _changePassword() async {
    String? errorMessage = HelperFunctions.validatePassword(newPasswordController);

    if (errorMessage != null) {
      // Show error message returned from validation function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Password Failed'),
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
      return; // Don't proceed with changing password if input is not valid
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
                  Navigator.of(context).pop();
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
        title: const Text('Change Password'),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PasswordTextField(
              controller: newPasswordController,
              hintTxt: 'New Password',
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
