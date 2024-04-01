import 'package:flutter/material.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/helper/helper_function.dart';

import '../../locator.dart';
import '../home_screen.dart';

class ChangeUsernamePage extends StatefulWidget {
  const ChangeUsernamePage({Key? key}) : super(key: key);

  @override
  _ChangeUsernamePageState createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage> {
  TextEditingController newUsernameController = TextEditingController();

  final UserController userController = locator.get<UserController>();

  Future<void> _changeUsername() async {
    // String? errorMessage = HelperFunctions.validateUsername(newUsernameController.text);
    //
    // if (errorMessage != null) {
    //   // Show error message returned from validation function
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Change Username Failed'),
    //         content: Text(errorMessage),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    //   return; // Don't proceed with changing username if input is not valid
    // }
    try {
      // Call the method to change the username
      userController.updateUserName(newUsernameController.text);
      // Display success dialog upon successful change of username
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Username Success'),
            content: const Text('Your username has been changed successfully.'),
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
      // Display an error dialog if changing username fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Username Failed'),
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
        title: const Text('Change Username'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ); // Navigate back to the previous page
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
              controller: newUsernameController,
              image: 'user.svg',
              hintTxt: 'New Username',
            ),
            const SizedBox(height: 20.0),
            Mainbutton(
              onTap: _changeUsername,
              text: 'Change Username',
              btnColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
